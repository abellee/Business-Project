var gui = require("nw.gui");
var win = gui.Window.get();
var md5 = require('MD5');
var ladda;
var baseWindow;
var ladda;

var changingData;
var changingIndex;
var tableId = 0;
var canClear = false;
var keys;
var tempTags;

var editingUser;
var editingTable;
var editingTableTemplate;
var editingKey;
var tempId;
var canEdit = false;
var serverTime = 0;
var tempTime = 0;
var isPreview = false;

var currentUser = JSON.parse(localStorage.user);

win.showDevTools("", false);

$(document).ready(init);

function init() {
    $("#exitBtn").on("click", exitApp);
    $("#logoutBtn").on("click", doLogout);

    if(currentUser.privilege == 1){
        $(".adminOnly").show();
    }

    $(window).on("resize", onWindowResize);

    $("#keysModal").on("show.bs.modal", onKeysModalShow);
    $("#usersModal").on("show.bs.modal", onUsersModalShow);
    $("#changePasswordModal").on("show.bs.modal", onPasswordModalShow);
    $("#changePasswordModal").on("hide.bs.modal", onPasswordModalHide);

    $("#addTableModal").on("show.bs.modal", onAddTableModalShow);
    $("#addKeyModal").on("show.bs.modal", onAddKeyModalShow);
    $("#addKeyModal").on("hide.bs.modal", onAddKeyModalHide);

    $("#createTableModal").on("show.bs.modal", onCreateTableModalShow);
    $("#tablesModal").on("show.bs.modal", onTablesModalShow);
    $("#tablesModal").on("hide.bs.modal", onTablesModalHide);

    $("#keysModal").on("hide.bs.modal", onModalHide);
    $("#usersModal").on("hide.bs.modal", onModalHide);
    $("#createTableModal").on("hide.bs.modal", onModalHide);
    $("#addTableModal").on("hide.bs.modal", onModalHide);

    $("#editTableModal").on("show.bs.modal", onEditTableModalShow);
    $("#editTableModal").on("hide.bs.modal", onEditTableModalHide);

    window.historyTableControllEvent = {
        "click .detail": function(e, value, row, index) {
            editingTable = row;
            isPreview = true;
            $("#editTableModal").modal("show");
        },
        "click .edit": function(e, value, row, index) {
            isPreview = false;
            editingTable = row;
            $("#editTableModal").modal("show");
        },
        "click .remove": function(e, value, row, index) {
            tempId = row.id;
            showConfirm("删除报表将可能影响将其作为数据源的报表，是否确定删除该报表？", function() {
                var path = gui.App.manifest.server + gui.App.manifest.app + "/api/delete_table";
                $.post(path, {
                    tid: tempId
                }, function(data) {
                    if (data.success) {
                        if (data.deleted) {
                            $.scojs_message('删除成功！', $.scojs_message.TYPE_OK);
                            $('#historyTable').bootstrapTable("refresh", {
                                silent: true
                            });
                        } else {
                            $.scojs_message('删除失败！', $.scojs_message.TYPE_ERROR);
                        }
                    } else {
                        $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                    }
                });
            });
        }
    };
    $('#historyTable').bootstrapTable({
        method: "get",
        url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_table",
        sidePagination: "server",
        cache: false,
        striped: false,
        pagination: true,
        pageSize: 100,
        search: true,
        pageList: [],
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function() {
            return "正在加载，请稍候...";
        },
        formatShowingRows: function(pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function() {
            return "搜索...";
        },
        formatNoMatches: function() {
            return "当前无任何数据...";
        },
        formatRefresh: function() {
            return "刷新";
        },
        formatRecordsPerPage: function(pageNumber) {
            return pageNumber + "条/页";
        },
        responseHandler: function(res) {
            serverTime = res.now;
            return res;
        },
        columns: [{
            field: 'id',
            title: 'ID',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'table_template',
            title: '报表名称',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.table_template) {
                    return row.table_template.table_name;
                }
                return "无";
            }
        }, {
            field: 'created_at',
            title: '创建时间',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'updated_at',
            title: '最近更新时间',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'user',
            title: '创建人',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.user) {
                    return row.user.real_name;
                }
                return "无";
            }
        }, {
            field: 'edit_user',
            title: '更新人',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.edit_user) {
                    return row.edit_user.real_name;
                }
                return "无";
            }
        }, {
            title: "操 作",
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (currentUser.privilege == 1) {
                    return [
                        '<a class="detail ml10" href="javascript:void(0)" title="查看"><i class="glyphicon glyphicon-th"></i></a>&nbsp;&nbsp;',
                        '<a class="edit ml10" href="javascript:void(0)" title="编辑">',
                        '<i class="glyphicon glyphicon-edit"></i>',
                        '</a>&nbsp;&nbsp;',
                        '<a class="remove ml10" href="javascript:void(0)" title="删除">',
                        '<i class="glyphicon glyphicon-remove"></i>',
                        '</a>'
                    ].join('');
                } else {
                    var str = '<a class="detail ml10" href="javascript:void(0)" title="查看"><i class="glyphicon glyphicon-th"></i></a>';
                    if (row.edit_user_id == 0 || row.temp_edit > serverTime) {
                        str += '&nbsp;&nbsp;<a class="edit ml10" href="javascript:void(0)" title="编辑"><i class="glyphicon glyphicon-edit"></i></a>';
                    }
                    return str;
                }
            },
            events: historyTableControllEvent
        }]
    });

    onWindowResize();
}

function onTablesModalHide() {
    editingTableTemplate = null;
    editingKey = null;
}

function onEditTableModalShow() {
    if (editingTable) {
        window.editingTableControllEvent = {
            "click .source": function(e, value, row, index) {
                var kid = row.id;
                $.get(gui.App.manifest.server + gui.App.manifest.app + "/api/data_source?kid=" + kid, function(data){
                    var anode = $("#editTable").find('a[kid="' + data.key_id + '"]');
                    if(anode[0]){
                        anode.parent().html(data.value);
                    }
                });
            }
        };

        $('#editTable').bootstrapTable("destroy");
        $('#editTable').bootstrapTable({
            method: 'get',
            url: gui.App.manifest.server + gui.App.manifest.app + "/api/data_by_tid?tid=" + editingTable.id,
            sidePagination: "server",
            height: 500,
            cache: false,
            striped: false,
            showColumns: false,
            formatLoadingMessage: function() {
                return "正在加载，请稍候...";
            },
            formatShowingRows: function(pageFrom, pageTo, totalRows) {
                return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
            },
            formatSearch: function() {
                return "搜索...";
            },
            formatNoMatches: function() {
                return "当前无任何数据...";
            },
            formatRefresh: function() {
                return "刷新";
            },
            formatRecordsPerPage: function(pageNumber) {
                return pageNumber + "条/页";
            },
            responseHandler: function(res) {
                serverTime = res.now;
                var data = res.rows;
                if (data.edit_user_id == 0 || data.temp_edit > serverTime) {
                    canEdit = true;
                    $("#tempEditGroup").hide();
                    $("#tempEditCtrl").hide();
                    $("#tempTime").show();
                    var leftTime = data.temp_edit - serverTime;
                    var num = leftTime;
                    var s = num % 60;
                    s = s < 0 ? 0 : s;
                    num = parseInt(num / 60);
                    var m = num % 60;
                    m = m < 0 ? 0 : m;
                    num = parseInt(num / 60);
                    var h = num % 24;
                    h = h < 0 ? 0 : h;
                    num = parseInt(num / 24);
                    var d = num;
                    d = d < 0 ? 0 : d;
                    $("#tempTime").text("临时可编辑时间:" + d + "天" + h + "小时" + m + "分钟" + s + "秒");
                    if(d == 0 && h == 0 && m == 0 && s == 0){
                        $("#tempTime").hide();
                    }
                } else {
                    canEdit = false;
                    $("#tempTime").hide();
                    if (currentUser.privilege == 1) {
                        $("#tempEditGroup").show();
                        $("#tempEditCtrl").show();
                        $("#tempEditUnit").removeAttr("readonly");
                        $("#tempEditUnit").select2("destroy");
                        $("#tempEditUnit").select2({
                            width: 80
                        });
                        $("#tempEditUnit").select2("val", 0);
                        $("#tempEditBtn").off("click");
                        $("#tempEditBtn").on("click", function() {
                            var time = parseInt($("#tempEditTime").val());
                            if (isNaN(time)) {
                                $.scojs_message('时长必须为整数！', $.scojs_message.TYPE_ERROR);
                                return;
                            }
                            var path = gui.App.manifest.server + gui.App.manifest.app + "/api/update_temp_edit";
                            $.post(path, {
                                tid: editingTable.id,
                                len: time * parseInt($("#tempEditUnit").select2("val"))
                            }, function(data) {
                                if (data.success) {
                                    $.scojs_message('设置成功！', $.scojs_message.TYPE_OK);
                                } else {
                                    $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                                }
                            });
                        });
                    }
                }
                if (data && data.keys) {
                    var rows = data.keys;
                    editingTable = data;
                    return {
                        "rows": rows
                    };
                }
                return res;
            },
            columns: [{
                field: 'key_template',
                title: '字段名称',
                halign: "center",
                align: "center",
                valign: "middle",
                formatter: function(value, row, index) {
                    if (row.key_template) {
                        var str = '<div class="control-group"><label class="control-label" for="input01">' + row.key_template.key_name + '</label></div>';
                        if (row.key_template.remark && row.key_template.remark != "") {
                            str += '<p class="help-block" style="font-size:12px;">' + row.key_template.remark + '</p>';
                        }
                        return str;
                    }
                    return '<span style="color:red;">数据出错</span>';
                }
            }, {
                field: 'value',
                title: '值',
                halign: "center",
                align: "center",
                valign: "middle",
                formatter: function(value, row, index) {
                    if (!isPreview) {
                        if (!row.data_source || !row.data_source.length) {
                            if (currentUser.privilege == 1 || canEdit) {
                                return '<div class="form-group" style="margin:0px;"><input type="text" class="value-cell form-control" value-type="' + row.value_type + '" key-id="' + row.id + '" value="' + (row.value ? row.value.value : "") + '"></div>';
                            }
                        } else {
                            return '<a class="source ml10" href="javascript:void(0)" title="获取数据源数据" kid="' + row.id + '"><i class="glyphicon glyphicon-folder-open"></i></a>';
                        }
                    } else if (row.data_source && row.data_source.length) {
                        return '<a class="source ml10" href="javascript:void(0)" title="获取数据源数据" kid="' + row.id + '"><i class="glyphicon glyphicon-folder-open"></i></a>';
                    }
                    return row.value ? row.value.value : "";
                },
                events: editingTableControllEvent
            }, {
                field: 'value_type',
                title: '值类型',
                halign: "center",
                align: "center",
                valign: "middle",
                formatter: function(value, row, index) {
                    if (row.value_type == 0) {
                        return "数字";
                    }
                    return "字符";
                }
            }, {
                field: 'remark',
                title: '值备注',
                halign: "center",
                align: "center",
                valign: "middle",
                formatter: function(value, row, index) {
                    if (!isPreview) {
                        if (canEdit || currentUser.privilege == 1) {
                            if (row.value) {
                                return '<input type="text" class="remark-cell form-control" key-id="' + row.id + '" value="' + (row.value.remark ? row.value.remark : "") + '">';
                            } else {
                                return '<input type="text" class="remark-cell form-control" key-id="' + row.id + '" value="">';
                            }
                        }
                    }
                    if (row.value) {
                        return row.value ? row.value.remark : "";
                    }
                    return "无";
                }
            }]
        });
        $("#updateTableBtn").off("click");
        $("#updateTableBtn").on("click", function() {
            if (currentUser.privilege != 1) {
                showConfirm("一旦提交数据，将无法再次修改，是否确认提交？", submitData);
            } else {
                submitData();
            }
        });
    }
}

function submitData() {
    ladda = Ladda.create($("#updateTableBtn")[0]);
    ladda.start();

    var valueCells = $("#editTable .value-cell").toArray();
    var remarkCells = $("#editTable .remark-cell").toArray();
    $("#editTable input").attr("readonly", "readonly");
    var arr = {};
    var valid = true;
    var validArr = [];
    valueCells.forEach(function(valueCell) {
        var cell = $(valueCell);
        arr[cell.attr("key-id")] = {};
        if (cell.hasClass("has-error")) {
            cell.removeClass("has-error");
        }
        var valueType = cell.attr("value-type");
        var cellVal = cell.val();
        if (valueType == 0) {
            var pattern = /^-?\d+\.?\d{0,}$/;
            if (!pattern.test(cellVal)) {
                valid = false;
                validArr.push(cell);
            } else {
                arr[cell.attr("key-id")]["value"] = cellVal;
            }
        } else {
            arr[cell.attr("key-id")]["value"] = cellVal;
        }
    });
    if (!valid) {
        $.scojs_message('提交的报表中存在值与值类型不匹配项，请修改后再次提交！', $.scojs_message.TYPE_ERROR);
        validArr.forEach(function(cell) {
            cell.parent().addClass("has-error");
        });
        ladda.stop();
        ladda = null;
        $("#editTable input").removeAttr("readonly");
        return;
    } else {
        remarkCells.forEach(function(remarkCell) {
            var cell = $(remarkCell);
            var remarkValue = cell.val();
            if (!arr[cell.attr("key-id")]) {
                arr[cell.attr("key-id")] = {};
            }
            arr[cell.attr("key-id")]["remark"] = $.trim(remarkValue);
        });
    }
    $.post(gui.App.manifest.server + gui.App.manifest.app + "/api/update_table_values", {
        values: arr,
        tid: editingTable.id
    }, function(data) {
        ladda.stop();
        ladda = null;
        $("#editTable input").removeAttr("readonly");
        if (data.success) {
            if (data.updated) {
                $.scojs_message('提交成功！', $.scojs_message.TYPE_OK);
                $("#editTableModal").modal("hide");
                $("#historyTable").bootstrapTable("refresh", {
                    silent: true
                });
            } else {
                $.scojs_message('提交失败，请稍候再试！', $.scojs_message.TYPE_ERROR);
            }
        } else {
            $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
        }
    });
}

function onEditTableModalHide() {
    editingTable = null;
    $("#tempEditGroup").hide();
    onModalHide();
}

function doLogout() {
    var modal = $.scojs_confirm({
        content: '是否确定注销当前帐号?',
        cssClass: 'system-font modal-class',
        action: function() {
            baseWindow.doLogout();
        }
    });
    modal.show();
}

function onPasswordModalShow() {
    var user = currentUser;
    $("#oldPassword").val("");
    $("#newPassword").val("");
    $("#userRealName").val(user.real_name);

    $("#modifyBtn").off("click");
    $("#modifyBtn").on("click", function() {
        var oldPw = $("#oldPassword").val();
        var newPw = $("#newPassword").val();
        var rn = $("#userRealName").val();
        oldPw = $.trim(oldPw);
        newPw = $.trim(newPw);
        rn = $.trim(rn);
        var pattern = /\s+/g;
        if (pattern.test(oldPw) || pattern.test(newPw)) {
            $.scojs_message('密码不能包含空格！', $.scojs_message.TYPE_ERROR);
            return;
        }
        if (oldPw == "" || newPw == "" || rn == "") {
            $.scojs_message('密码不能为空！', $.scojs_message.TYPE_ERROR);
            return;
        }
        ladda = Ladda.create(this);
        ladda.start();

        $.post(gui.App.manifest.server + gui.App.manifest.app + "/api/update_user", {
            uid: user.id,
            pw: oldPw,
            npw: newPw,
            rn: rn
        }, function(data) {
            ladda.stop();
            ladda = null;
            if (data.success) {
                if (data.updated) {
                    $.scojs_message("更新成功！", $.scojs_message.TYPE_OK);
                    localStorage.user = JSON.stringify(data.data);
                    currentUser = data.data;
                    $("#changePasswordModal").modal("hide");
                } else {
                    $.scojs_message("更新失败，请稍候重试！", $.scojs_message.TYPE_ERROR);
                    $("#oldPassword").removeAttr("readonly");
                    $("#newPassword").removeAttr("readonly");
                    $("#userRealName").removeAttr("readonly");
                }
            } else {
                $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                $("#oldPassword").removeAttr("readonly");
                $("#newPassword").removeAttr("readonly");
                $("#userRealName").removeAttr("readonly");
            }
        });
    });
}

function onPasswordModalHide() {
    $("#oldPassword").val("");
    $("#newPassword").val("");
    $("#userRealName").val("");
    $("#oldPassword").removeAttr("readonly");
    $("#newPassword").removeAttr("readonly");
    $("#userRealName").removeAttr("readonly");
}

function onKeysModalShow() {
    window.keysTemplateAddControllEvent = {
        "click .edit": function(e, value, row, index) {
            changingData = row;
            changingIndex = index;
            $("#submitBtn span").text("修改字段");
            $("#keyTemplateName").val(row.key_name);
            $("#keyTemplateRemark").val(row.remark);
        },
        "click .remove": function(e, value, row, index) {
            changingData = row;
            bootbox.dialog({
                message: "是否确定删除此字段?",
                buttons: {
                    cancel: {
                        label: "取消",
                        className: "btn-default"
                    },
                    success: {
                        label: "确定",
                        className: "btn-danger",
                        callback: function() {
                            var path = gui.App.manifest.server + gui.App.manifest.app + "/api/delete_key_template";
                            var param = {
                                id: changingData.id
                            };
                            $.post(path, param, function(data) {
                                if (data.success && data.deleted) {
                                    $('#keysTable').bootstrapTable("refresh", {
                                        slient: true
                                    });
                                    $("#resetBtn").trigger("click");
                                    $.scojs_message('删除成功!', $.scojs_message.TYPE_OK);
                                } else {
                                    $.scojs_message('删除失败，请修改重试!', $.scojs_message.TYPE_ERROR);
                                }
                            });
                        }
                    }
                }
            });
        }
    }
    $('#keysTable').bootstrapTable({
        method: 'get',
        url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_key_template",
        sidePagination: "server",
        cache: false,
        height: 300,
        striped: false,
        pagination: true,
        pageSize: 10,
        search: true,
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function() {
            return "正在加载，请稍候...";
        },
        formatShowingRows: function(pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function() {
            return "搜索...";
        },
        formatNoMatches: function() {
            return "当前无任何数据...";
        },
        formatRefresh: function() {
            return "刷新";
        },
        formatRecordsPerPage: function(pageNumber) {
            return pageNumber + "条/页";
        },
        columns: [{
            field: 'key_name',
            title: '字段名称',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'remark',
            title: '备 注',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'created_at',
            title: '创建时间',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'updated_at',
            title: '最近更新时间',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            title: "操 作",
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                return [
                    '<a class="edit ml10" href="javascript:void(0)" title="编辑">',
                    '<i class="glyphicon glyphicon-edit"></i>',
                    '</a>',
                    '<a class="remove ml10" href="javascript:void(0)" title="删除">',
                    '<i class="glyphicon glyphicon-remove"></i>',
                    '</a>'
                ].join('');
            },
            events: keysTemplateAddControllEvent
        }]
    });

    $("#resetBtn").on("click", function() {
        changingData = null;
        $("#keyTemplateName").val("");
        $("#keyTemplateRemark").val("");
        $("#submitBtn span").text("添加字段");
    });

    $("#submitBtn span").text("添加字段");
    $("#keyTemplateName").val("");
    $("#keyTemplateRemark").val("");

    $("#submitBtn").on("click", function() {
        var keyName = $("#keyTemplateName").val();
        var keyRemark = $("#keyTemplateRemark").val();
        keyName = $.trim(keyName);
        keyRemark = $.trim(keyRemark);
        if (keyName == "") {
            $.scojs_message('字段名称不能为空!', $.scojs_message.TYPE_ERROR);
            return;
        }

        if (ladda) return;
        $("#keyTemplateName").attr("readonly", "readonly");
        $("#keyTemplateRemark").attr("readonly", "readonly");
        ladda = Ladda.create(this);
        ladda.start();
        var path = gui.App.manifest.server + gui.App.manifest.app + "/api/create_key_template";
        var param = {
            kn: keyName,
            rm: keyRemark
        };
        if (changingData) {
            path = gui.App.manifest.server + gui.App.manifest.app + "/api/update_key_template";
            param.id = changingData.id;
        }
        $.post(path, param, function(data) {
            ladda.stop();
            ladda = null;
            $("#keyTemplateName").removeAttr("readonly");
            $("#keyTemplateRemark").removeAttr("readonly");
            if (!data || !data.success) {
                if (data && data.msg) {
                    $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                } else {
                    $.scojs_message('操作失败，请稍候重试!', $.scojs_message.TYPE_ERROR);
                }
            } else {
                if (data.added) {
                    $("#keyTemplateName").val("");
                    $("#keyTemplateRemark").val("");
                    $('#keysTable').bootstrapTable("refresh", {
                        slient: true
                    });
                    $.scojs_message('添加成功!', $.scojs_message.TYPE_OK);
                    return;
                } else if (data.update) {
                    $("#keyTemplateName").val("");
                    $("#keyTemplateRemark").val("");
                    $('#keysTable').bootstrapTable("updateRow", {
                        silent: true,
                        index: changingIndex,
                        row: data.data
                    });
                    $("#resetBtn").trigger("click");
                    $.scojs_message('更新成功!', $.scojs_message.TYPE_OK);
                    return;
                }
                $.scojs_message('操作失败，请稍候重试!', $.scojs_message.TYPE_ERROR);
            }
        });
    });
}

function onUsersModalShow() {
    window.usersListControllEvent = {
        "click .edit": function(e, value, row, index) {
            editingUser = row;
            $("#username").attr("readonly", "readonly");
            $("#userAddBtn span").text("更新财务");

            $("#username").val(editingUser.uname);
            $("#password").val("");
            $("#realname").val(editingUser.real_name);
        },
        "click .remove": function(e, value, row, index) {
            showConfirm("是否确认删除该财务帐号?", function() {
                var path = gui.App.manifest.server + gui.App.manifest.app + "/api/delete_user";
                var param = {
                    id: row.id
                };
                $.post(path, param, function(data) {
                    if (data.success) {
                        if (data.deleted) {
                            $.scojs_message('删除成功！', $.scojs_message.TYPE_OK);
                            $('#usersTable').bootstrapTable("refresh", {
                                silent: true
                            });
                        } else {
                            $.scojs_message('删除失败，请稍候再试！', $.scojs_message.TYPE_ERROR);
                        }
                    } else {
                        $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                    }
                });
            });
        }
    }

    $("#resetUserBtn").off("click");
    $("#resetUserBtn").on("click", function() {
        editingUser = null;
        $("#username").removeAttr("readonly");
        $("#password").removeAttr("readonly");
        $("#realname").removeAttr("readonly");
        $("#username").val("");
        $("#password").val("");
        $("#realname").val("");
        $("#userAddBtn span").text("添加财务");
        recreateUserTable();
    });
    $("#resetUserBtn").trigger("click");

    $("#userAddBtn").off("click");
    $("#userAddBtn").on("click", function() {
        var un = $("#username").val();
        var pw = $("#password").val();
        var rn = $("#realname").val();
        un = $.trim(un);
        pw = $.trim(pw);
        rn = $.trim(rn);
        var pattern = /\s+/g;
        if (pattern.test(un) || pattern.test(pw)) {
            $.scojs_message('用户名或密码不能包含空格！', $.scojs_message.TYPE_ERROR);
            return;
        }
        if (un == "" || pw == "" || rn == "") {
            $.scojs_message('用户名、密码及真实姓名不能为空！', $.scojs_message.TYPE_ERROR);
            return;
        }
        $("#username").attr("readonly", "readonly");
        $("#password").attr("readonly", "readonly");
        $("#realname").attr("readonly", "readonly");
        ladda = Ladda.create(this);
        ladda.start();

        var path = gui.App.manifest.server + gui.App.manifest.app + "/api/add_user";
        var param = {
            acc: un,
            pw: pw,
            rn: rn
        };
        if (editingUser) {
            path = gui.App.manifest.server + gui.App.manifest.app + "/api/update_user";
            delete param.acc;
            param.uid = editingUser.id;
        }
        $.post(path, param, function(data) {
            ladda.stop();
            ladda = null;
            if (data.success) {
                if (data.added || data.updated) {
                    if (editingUser) {
                        $.scojs_message('添加成功！', $.scojs_message.TYPE_OK);
                    } else {
                        $.scojs_message('更新成功！', $.scojs_message.TYPE_OK);
                    }
                    editingUser = null;
                    $('#usersTable').bootstrapTable("refresh", {
                        silent: true
                    });
                    $("#resetUserBtn").trigger("click");
                } else {
                    if (editingUser) {
                        $.scojs_message('更新失败，请稍候重试！', $.scojs_message.TYPE_ERROR);
                    } else {
                        $.scojs_message('添加失败，请稍候重试！', $.scojs_message.TYPE_ERROR);
                        $("#username").removeAttr("readonly");
                    }
                    $("#password").removeAttr("readonly");
                    $("#realname").removeAttr("readonly");
                }
            } else {
                $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                $("#username").removeAttr("readonly");
                $("#password").removeAttr("readonly");
                $("#realname").removeAttr("readonly");
            }
        });
    });
}

function recreateUserTable() {
    $('#usersTable').bootstrapTable("destroy");
    $('#usersTable').bootstrapTable({
        method: 'get',
        url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_users",
        sidePagination: "server",
        cache: false,
        height: 300,
        striped: false,
        pagination: true,
        pageSize: 10,
        search: true,
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function() {
            return "正在加载，请稍候...";
        },
        formatShowingRows: function(pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function() {
            return "搜索...";
        },
        formatNoMatches: function() {
            return "当前无任何数据...";
        },
        formatRefresh: function() {
            return "刷新";
        },
        formatRecordsPerPage: function(pageNumber) {
            return pageNumber + "条/页";
        },
        columns: [{
            field: 'uname',
            title: '用户名',
            halign: "center",
            align: "center",
            vlign: "middle"
        }, {
            field: 'real_name',
            title: '真实姓名',
            halign: "center",
            align: "center",
            vlign: "middle"
        }, {
            field: 'created_at',
            title: '创建时间',
            halign: "center",
            align: "center",
            vlign: "middle"
        }, {
            field: 'updated_at',
            title: '最近更新时间',
            halign: "center",
            align: "center",
            vlign: "middle"
        }, {
            title: "操 作",
            halign: "center",
            align: "center",
            vlign: "middle",
            formatter: function(value, row, index) {
                return [
                    '<a class="edit ml10" href="javascript:void(0)" title="编辑">',
                    '<i class="glyphicon glyphicon-edit"></i>',
                    '</a>',
                    '<a class="remove ml10" href="javascript:void(0)" title="删除">',
                    '<i class="glyphicon glyphicon-remove"></i>',
                    '</a>'
                ].join('');;
            },
            events: usersListControllEvent
        }]
    });
}

function onAddTableModalShow() {
    canClear = true;

    $("#scopeSelect").select2({
        width: 300
    });
    $("#scopeSelect").off("change");
    $("#scopeSelect").on("change", function(event) {
        if ($("#scopeSelect").select2("val") == 1) {
            $("#userIds").select2("enable", true);
            $("#userIds").select2("val", "");
            $("#userIds").select2({
                width: "100%",
                placeholder: "请指定报表可见的财务人员",
                loadMorePadding: 10,
                multiple: true,
                ajax: {
                    url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_users",
                    dataType: "json",
                    data: function(term, page) {
                        return {
                            limit: page * 10,
                            offset: (page - 1) * 10
                        }
                    },
                    results: function(term, page) {
                        return {
                            results: term.rows,
                            more: page * 10 < term.total
                        }
                    }
                },
                formatResult: function(item) {
                    return item.real_name;
                },
                formatSelection: function(item) {
                    return item.real_name;
                },
                formatLoadMore: function(pageNumber) {
                    return "正在加载，请稍候..."
                },
                formatNoMatches: function(term) {
                    return "无任何数据";
                },
                formatSearching: function() {
                    return "正在加载，请稍候..."
                },
                formatAjaxError: function(jqXHR, textStatus, errorThrown) {
                    return "status:" + textStatus + " error:" + errorThrown;
                }
            });
        } else {
            $("#userIds").select2("val", "");
            $("#userIds").select2("destroy");
        }
    });

    $("#isDisabled").bootstrapSwitch({
        onText: "是",
        offText: "否"
    });

    $("#cancelTableAdd").off("click");
    $("#cancelTableAdd").on("click", function() {
        if ((keys || $("#tableName").val() != "") && tableId == 0 && !editingTableTemplate) {
            showConfirm("有数据未保存，是否确认退出?", function() {
                $("#addTableModal").modal("hide");
                editingTableTemplate = null;
            });
        } else {
            $("#addTableModal").modal("hide");
            editingTableTemplate = null;
        }
    });

    $("#tableName").removeAttr("readonly");
    $("#scopeSelect").select2("enable", true);
    $("#isDisabled").bootstrapSwitch("readonly", false);
    $("#tableName").val("");
    $("#scopeSelect").select2("val", 0);
    $("#scopeSelect").trigger("change");
    $("#isDisabled").bootstrapSwitch("state", true);
    if (editingTableTemplate) {
        if (editingTableTemplate.disabled == 1) {
            $("#isDisabled").bootstrapSwitch("state", false);
        }
        $("#scopeSelect").select2("val", editingTableTemplate.scope);
        $("#scopeSelect").trigger("change");
        var arr = [];
        editingTableTemplate.table_scope.forEach(function(ts) {
            if (ts.user) {
                arr.push(ts.user);
            }
        });
        $("#userIds").select2("data", arr);
        if (arr.length) {
            $("#userIds").select2("enable", true);
        }
        $("#tableName").val(editingTableTemplate.table_name);
    }

    $("#addTableBtn span").text("添加报表");
    if (editingTableTemplate) {
        $("#addTableBtn span").text("修改报表");
    }
    $("#addTableBtn").off("click");
    $("#addTableBtn").on("click", function() {
        if ((!keys || !keys.length) && !editingTableTemplate) {
            $.scojs_message('该报表未添加任何字段，无法保存!', $.scojs_message.TYPE_ERROR);
            return;
        }
        var tableName = $("#tableName").val();
        tableName = $.trim(tableName);
        if (tableName == "") {
            $.scojs_message('报表名称不能为空!', $.scojs_message.TYPE_ERROR);
            return;
        }
        var scopeSelect = $("#scopeSelect").select2("val");
        var ids = $("#userIds").select2("val");
        if (scopeSelect == 1 && (!ids || ids == "")) {
            $.scojs_message('请指定可见的财务人员!', $.scojs_message.TYPE_ERROR);
            return;
        } else if (scopeSelect == 0) {
            ids = [];
        }
        var enabled = $("#isDisabled").bootstrapSwitch("state");
        var disabled = 0;
        if (enabled) {
            disabled = 0;
        } else {
            disabled = 1;
        }

        ladda = Ladda.create(this);
        ladda.start();

        $("#tableName").attr("readonly", "readonly");
        $("#scopeSelect").select2("enable", false);
        $("#userIds").select2("enable", false);
        $("#isDisabled").bootstrapSwitch("readonly", true);

        var params = {
            disabled: disabled,
            daysNum: 0,
            ids: ids,
            tn: tableName,
            type: 0,
            scope: scopeSelect,
            keys: keys
        }
        var path = gui.App.manifest.server + gui.App.manifest.app + "/api/create_table_template";
        if (editingTableTemplate) {
            path = gui.App.manifest.server + gui.App.manifest.app + "/api/update_table_template";
            params.tid = editingTableTemplate.id;
        }
        $.post(path, params, function(data) {
            ladda.stop();
            ladda = null;
            if (data.success) {
                if (data.added) {
                    $.scojs_message('添加报表成功!', $.scojs_message.TYPE_OK);
                    $("#addTableModal").modal("hide");
                } else if (data.updated) {
                    $.scojs_message('更新报表成功!', $.scojs_message.TYPE_OK);
                    $("#addTableModal").modal("hide");
                    $("#tablesTable").bootstrapTable("refresh", {
                        silent: true
                    });
                } else {
                    $.scojs_message('添加报表失败，请稍候重试!', $.scojs_message.TYPE_ERROR);
                    $("#tableName").removeAttr("readonly");
                    $("#scopeSelect").select2("enable", true);
                    $("#userIds").select2("enable", true);
                    $("#isDisabled").bootstrapSwitch("readonly", false);
                }
            } else {
                $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                $("#tableName").removeAttr("readonly");
                $("#scopeSelect").select2("enable", true);
                $("#userIds").select2("enable", true);
                $("#isDisabled").bootstrapSwitch("readonly", false);
            }
        });
    });
}

function onAddKeyModalHide() {
    tempTags = [];
    if (editingTableTemplate) {
        keys = null;
    }
    editingKey = null;
    $("#addTableModal").modal("show");
}

function onModalHide() {
    changingData = null;

    $('#keysTable').bootstrapTable("destroy");

    if (canClear) {
        $("#addTableModal").bootstrapTable("destroy");
        $("#addKeyModal").bootstrapTable("destroy");
        tableId = 0;
        keys = null;
        canClear = false;
        tempTags = [];
        if (ladda) {
            ladda.stop();
            ladda = null;
        }
    }

    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
}

function onCreateTableModalShow() {
    $("#createTableSelect").select2("destroy");
    $("#createTableSelect").select2("val", "");
    $("#createTableSelect").select2({
        width: "100%",
        placeholder: "请选择报表模板",
        loadMorePadding: 10,
        ajax: {
            url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_template",
            dataType: "json",
            data: function(term, page) {
                return {
                    limit: page * 10,
                    offset: (page - 1) * 10
                }
            },
            results: function(term, page) {
                var result;
                if (currentUser.privilege == 1) {
                    result = term.rows;
                } else {
                    result = [];
                    term.rows.forEach(function(item) {
                        result.push(item.table_template);
                    });
                }
                return {
                    results: result,
                    more: page * 10 < term.total
                }
            }
        },
        formatResult: function(item) {
            return item.table_name;
        },
        formatSelection: function(item) {
            return item.table_name;
        },
        formatLoadMore: function(pageNumber) {
            return "正在加载，请稍候..."
        },
        formatNoMatches: function(term) {
            return "无任何数据";
        },
        formatSearching: function() {
            return "正在加载，请稍候..."
        },
        formatAjaxError: function(jqXHR, textStatus, errorThrown) {
            return "status:" + textStatus + " error:" + errorThrown;
        }
    });
    $("#createTableSelect").select2("enable", true);

    $("#createTableBtn").off("click");
    $("#createTableBtn").on("click", function() {
        ladda = Ladda.create(this);
        ladda.start();
        var tid = $("#createTableSelect").select2("val");
        var path = gui.App.manifest.server + gui.App.manifest.app + "/api/create_table";
        $.post(path, {
            tid: tid
        }, function(data) {
            ladda.stop();
            ladda = null;
            if (data.success) {
                if (data.added) {
                    $.scojs_message('创建成功!', $.scojs_message.TYPE_OK);
                    $("#historyTable").bootstrapTable("refresh", {
                        silent: true
                    });
                    $("#createTableModal").modal("hide");
                } else {
                    $.scojs_message('创建报表失败!', $.scojs_message.TYPE_ERROR);
                }
            } else {
                $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
            }
        });
    });
}

function onTablesModalShow() {
    window.tablesTableControllEvent = {
        "click .edit": function(e, value, row, index) {
            editingTableTemplate = row;
            $("#addTableModal").modal("show");
        },
        "click .remove": function(e, value, row, index) {
            tempId = row.id;
            showConfirm("是否确认删除该报表模板？", function() {
                $.post(gui.App.manifest.server + gui.App.manifest.app + "/api/delete_table_template", {
                    tid: tempId
                }, function(data) {
                    if (data.success) {
                        if (data.deleted) {
                            $.scojs_message('删除成功!', $.scojs_message.TYPE_OK);
                            $('#tablesTable').bootstrapTable("refresh", {
                                silent: true
                            });
                        } else {
                            $.scojs_message('删除失败，请稍候再试！!', $.scojs_message.TYPE_ERROR);
                        }
                    } else {
                        $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                    }
                });
            });
        }
    }
    $('#tablesTable').bootstrapTable("destroy");
    $('#tablesTable').bootstrapTable({
        method: 'get',
        url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_table_template",
        sidePagination: "server",
        cache: false,
        height: 500,
        striped: false,
        pagination: true,
        pageSize: 20,
        search: true,
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function() {
            return "正在加载，请稍候...";
        },
        formatShowingRows: function(pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function() {
            return "搜索...";
        },
        formatNoMatches: function() {
            return "当前无任何数据...";
        },
        formatRefresh: function() {
            return "刷新";
        },
        formatRecordsPerPage: function(pageNumber) {
            return pageNumber + "条/页";
        },
        columns: [{
            field: 'table_name',
            title: '报表名称',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'scope',
            title: '可见范围',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (value == 0) {
                    return "所有财务";
                }
                return "指定财务";
            }
        }, {
            field: 'disabled',
            title: '是否可用',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (value == 0) {
                    return '<span class="glyphicon glyphicon-ok"></span>';
                }
                return '<span class="glyphicon glyphicon-remove"></span>';
            }
        }, {
            field: 'created_at',
            title: '创建时间',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'updated_at',
            title: '最近更新时间',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            title: "操 作",
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                return [
                    '<a class="edit ml10" href="javascript:void(0)" title="编辑">',
                    '<i class="glyphicon glyphicon-edit"></i>',
                    '</a>&nbsp;&nbsp;',
                    '<a class="remove ml10" href="javascript:void(0)" title="删除">',
                    '<i class="glyphicon glyphicon-remove"></i>',
                    '</a>'
                ].join('');;
            },
            events: tablesTableControllEvent
        }]
    });
}

function onAddKeyModalShow(isreset) {
    canClear = false;
    if (!isreset) $("#addTableModal").modal("hide");
    $("#selectKey").select2("destroy");
    $("#selectKey").select2({
        width: 300,
        placeholder: "选择字段",
        loadMorePadding: 10,
        ajax: {
            url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_key_template",
            dataType: "json",
            data: function(term, page) {
                return {
                    search: term,
                    limit: page * 10,
                    offset: (page - 1) * 10
                }
            },
            results: function(term, page) {
                return {
                    results: term.rows,
                    more: page * 10 < term.total
                }
            }
        },
        formatResult: function(item) {
            return item.key_name;
        },
        formatSelection: function(item) {
            return item.key_name;
        },
        formatLoadMore: function(pageNumber) {
            return "正在加载，请稍候..."
        },
        formatNoMatches: function(term) {
            return "无任何数据";
        },
        formatSearching: function() {
            return "正在加载，请稍候..."
        },
        formatAjaxError: function(jqXHR, textStatus, errorThrown) {
            return "status:" + textStatus + " error:" + errorThrown;
        },
        initSelection: function(element, callback) {
            callback(element);
        },
    });
    $("#selectValueType").select2("val", "");
    $("#selectValueType").select2("destroy");
    $("#selectValueType").select2({
        width: 300
    });
    $("#selectSourceTable").off("change");
    $("#selectSourceTable").select2("val", "");
    $("#selectSourceTable").select2("destroy");

    tempTags = [];
    $("#selectSourceKey").select2("val", "");
    $("#selectSourceKey").select2("destroy");
    $("#selectSourceKey").hide();

    $("#selectSourceTable").select2({
        width: 300,
        placeholder: "选择数据源表",
        loadMorePadding: 10,
        ajax: {
            url: gui.App.manifest.server + gui.App.manifest.app + "/api/all_table_template",
            dataType: "json",
            data: function(term, page) {
                return {
                    search: term,
                    limit: page * 10,
                    offset: (page - 1) * 10
                }
            },
            results: function(term, page) {
                return {
                    results: term.rows,
                    more: page * 10 < term.total
                }
            }
        },
        formatResult: function(item) {
            return item.table_name;
        },
        formatSelection: function(item) {
            return item.table_name;
        },
        formatLoadMore: function(pageNumber) {
            return "正在加载，请稍候..."
        },
        formatNoMatches: function(term) {
            return "无任何数据";
        },
        formatSearching: function() {
            return "正在加载，请稍候..."
        },
        formatAjaxError: function(jqXHR, textStatus, errorThrown) {
            return "status:" + textStatus + " error:" + errorThrown;
        }
    }).on("select2-selecting", function(e) {
        var tid = e.val;
        $("#selectSourceKey").show();
        $("#selectSourceKey").select2({
            width: "100%",
            placeholder: "选择数据源字段",
            loadMorePadding: 10,
            multiple: true,
            cache: true,
            ajax: {
                url: gui.App.manifest.server + gui.App.manifest.app + "/api/keys_by_tid?tid=" + tid,
                dataType: "json",
                data: function(term, page) {
                    return {
                        search: term,
                        limit: page * 10,
                        offset: (page - 1) * 10
                    }
                },
                results: function(term, page) {
                    return {
                        results: term.rows,
                        more: page * 10 < term.total
                    }
                }
            },
            initSelection: function(element, callback) {
                callback(tempTags);
            },
            formatResult: function(item) {
                var typeStr = "数字";
                if (item.value_type == 1) {
                    typeStr = "字符";
                }
                return item.key_template.key_name + "[值类型: " + typeStr + ", 备注:" + item.remark + "]";
            },
            formatSelection: function(item) {
                var typeStr = "数字";
                if (item.value_type == 1) {
                    typeStr = "字符";
                }
                var exist = false;
                tempTags.forEach(function(tag) {
                    if (tag.id == item.id) {
                        exist = true;
                        return true;
                    }
                });
                if (!exist) {
                    tempTags.push(item);
                }
                return item.key_template.key_name + "[值类型: " + typeStr + "]";
            },
            formatLoadMore: function(pageNumber) {
                return "正在加载，请稍候..."
            },
            formatNoMatches: function(term) {
                return "无任何数据";
            },
            formatSearching: function() {
                return "正在加载，请稍候..."
            },
            formatAjaxError: function(jqXHR, textStatus, errorThrown) {
                return "status:" + textStatus + " error:" + errorThrown;
            }
        }).on("select2-removed", function(event) {
            tempTags.forEach(function(tag) {
                if (tag.id == event.val) {
                    var index = tempTags.indexOf(tag);
                    tempTags.splice(index, 1);
                    return true;
                }
            });
        });
    });

    if (editingTableTemplate) {
        tableId = editingTableTemplate.id;
    }

    editingKey = null;
    window.templateKeyControllEvent = {
        "click .edit": function(e, value, row, index) {
            editingKey = row;
            $("#keyAddBtn span").text("修改字段");
            $("#selectKey").select2("data", editingKey.key_template);
            $("#selectValueType").select2("val", editingKey.value_type);
            if (editingKey.data_source && editingKey.data_source.length) {
                $("#selectSourceTable").select2("data", editingKey.data_source[0].table_template);
                $("#selectSourceTable").trigger("select2-selecting");

                tempTags = [];
                editingKey.data_source.forEach(function(source) {
                    tempTags.push(source.source_key);
                });
                $("#selectSourceKey").select2("data", tempTags);
                $("#addKeyRemark").val(editingKey.remark);
            }
        },
        "click .remove": function(e, value, row, index) {
            tempId = row.id;
            showConfirm("是否确定删除此字段？", function() {
                $.post(gui.App.manifest.server + gui.App.manifest.app + "/api/delete_key", {
                    id: tempId
                }, function(data) {
                    if (data.success) {
                        if (data.deleted) {
                            $.scojs_message('删除成功!', $.scojs_message.TYPE_OK);
                            $('#addKeyTable').bootstrapTable("refresh", {
                                silent: true
                            });
                        } else {
                            $.scojs_message('删除失败，请稍候再试！!', $.scojs_message.TYPE_ERROR);
                        }
                    } else {
                        $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                    }
                });
            });
        }
    }

    $('#addKeyTable').bootstrapTable("destroy");
    $('#addKeyTable').bootstrapTable({
        method: "get",
        url: gui.App.manifest.server + gui.App.manifest.app + "/api/keys_by_tid?tid=" + tableId,
        sidePagination: "server",
        cache: false,
        height: 300,
        striped: false,
        pagination: true,
        pageSize: 10,
        search: true,
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function() {
            return "正在加载，请稍候...";
        },
        formatShowingRows: function(pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function() {
            return "搜索...";
        },
        formatNoMatches: function() {
            return "当前无任何数据...";
        },
        formatRefresh: function() {
            return "刷新";
        },
        formatRecordsPerPage: function(pageNumber) {
            return pageNumber + "条/页";
        },
        columns: [{
            field: "key_template.key_name",
            title: '字段名称',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.key_template) {
                    return row.key_template.key_name;
                }
            }
        }, {
            field: "value_type",
            title: '值类型',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.value_type == 0) {
                    return "数字";
                }
                return "字符";
            }
        }, {
            field: "data_source",
            title: '数据源表',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.data_source && row.data_source.length) {
                    var strs = [];
                    row.data_source.forEach(function(source) {
                        strs.push(source.source_key.table_template.table_name);
                    });
                    return strs.join(", ");
                }
            }
        }, {
            field: "data_source",
            title: '数据源字段',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.data_source && row.data_source.length) {
                    var strs = [];
                    row.data_source.forEach(function(source) {
                        strs.push(source.source_key.key_template.key_name);
                    });
                    return strs.join(", ");
                }
            }
        }, {
            field: "remark",
            title: '备注',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: "remark",
            title: '操作',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                return [
                    '<a class="edit ml10" href="javascript:void(0)" title="编辑">',
                    '<i class="glyphicon glyphicon-edit"></i>',
                    '</a>&nbsp;&nbsp;',
                    '<a class="remove ml10" href="javascript:void(0)" title="删除">',
                    '<i class="glyphicon glyphicon-remove"></i>',
                    '</a>'
                ].join('');;
            },
            events: templateKeyControllEvent
        }]
    });

    $("#keyAddBtn span").text("添加字段");
    $("#resetKeyAddBtn").off("click");
    $("#resetKeyAddBtn").on("click", function() {
        onAddKeyModalShow(true);
    });

    if (editingTableTemplate) {
        keys = [];
        if (editingTableTemplate.key && editingTableTemplate.key.length) {
            editingTableTemplate.key.forEach(function(key) {
                var obj = {};
                obj.key_template_id = key.key_template_id;
                obj.table_template_id = key.table_template_id;
                obj.remark = key.remark;
                obj.value_type = key.value_type;
                obj.key_id = key.id;
                obj.source = [];
                if (key.data_source && key.data_source.length) {
                    var arr = [];
                    key.data_source.forEach(function(s) {
                        arr.push({
                            source_table_template_id: s.source_table_template_id,
                            source_key_id: s.source_key_id
                        });
                    });
                    obj.source = arr;
                }
                keys.push(obj);
            });
        }
    }

    $("#addKeyRemark").val("");
    $("#keyAddBtn").off("click");
    $("#keyAddBtn").on("click", function() {
        var selectKey = $("#selectKey").select2("val");
        if (!selectKey || selectKey == "") {
            $.scojs_message('请选择字段!', $.scojs_message.TYPE_ERROR);
            return;
        }
        var selectedType = $("#selectValueType").select2("val");
        if (!selectedType || selectedType == "") {
            $.scojs_message('请选择值类型!', $.scojs_message.TYPE_ERROR);
            return;
        }
        var obj = {
            key_template_id: selectKey,
            value_type: selectedType
        };
        var selectSourceTable = $("#selectSourceTable").select2("val");
        var selectSourceKey = $("#selectSourceKey").select2("val");
        if (selectSourceTable && selectSourceTable != "" && (!selectSourceKey || selectSourceKey == "")) {
            $.scojs_message('请选择数据源字段!', $.scojs_message.TYPE_ERROR);
            return;
        }

        var source = [];
        if (tempTags) {
            var bool = true;
            tempTags.forEach(function(tag) {
                if (tag.value_type != selectedType) {
                    bool = false;
                    return true;
                }
                source.push({
                    source_table_template_id: tag.table_template_id,
                    source_key_id: tag.id
                });
            });
            if (!bool) {
                $.scojs_message('数据源字段值类型与选择的值类型必须相同!', $.scojs_message.TYPE_ERROR);
                return;
            }
        }
        obj.source = source;
        obj.remark = $.trim($("#addKeyRemark").val());
        if (editingKey) {
            obj.key_id = editingKey.id;
        }
        if (existInKeys(obj)) {
            $.scojs_message('已有完全相同的字段存在!', $.scojs_message.TYPE_ERROR);
            return;
        }

        var path = gui.App.manifest.server + gui.App.manifest.app + "/api/update_key";
        if (editingKey) { // update
            $.post(path, {
                key_id: editingKey.id,
                kti: selectKey,
                vt: selectedType,
                remark: obj.remark,
                ids: source
            }, function(data) {
                if (data.success) {
                    if (data.updated) {
                        $.scojs_message('更新成功!', $.scojs_message.TYPE_OK);
                        $('#addKeyTable').bootstrapTable("refresh", {
                            silent: true
                        });
                        onAddKeyModalShow(true);
                    } else {
                        $.scojs_message('更新失败，请稍候重试！!', $.scojs_message.TYPE_ERROR);
                    }
                } else {
                    $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                }
            });
        } else {
            if (editingTableTemplate) { // add key to exsiting table template
                $.post(path, {
                    kti: selectKey,
                    tti: editingTableTemplate.id,
                    vt: selectedType,
                    remark: obj.remark,
                    ids: source
                }, function(data) {
                    if (data.success) {
                        if (data.updated) {
                            $.scojs_message('添加成功!', $.scojs_message.TYPE_OK);
                            $('#resetAddKey').bootstrapTable("refresh", {
                                silent: true
                            });
                            onAddKeyModalShow(true);
                        } else {
                            $.scojs_message('添加失败，请稍候重试！!', $.scojs_message.TYPE_ERROR);
                        }
                    } else {
                        $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                    }
                });
            } else {
                if (!keys) {
                    keys = [];
                }
                keys.push(obj);
                tempTags = [];
                $("#selectKey").select2("val", "");
                $("#selectValueType").select2("val", "0");
                $("#selectSourceTable").select2("val", "");
                $("#selectSourceKey").select2("val", "");
                $("#addKeyRemark").val("");
            }
        }
    });
}

function existInKeys(obj) {
    var bool = false;
    if (keys) {
        keys.forEach(function(key) {
            if (key.source_table_template_id == obj.source_table_template_id && key.source_key_id == obj.source_key_id && obj.key_template_id == key.key_template_id && obj.value_type == key.value_type) {
                if (obj.source.length == key.source.length) {
                    if (obj.key_id && key.key_id && obj.key_id == key.key_id && editingKey) {
                        bool = false;
                        return true;
                    }
                    var len = obj.source.length;
                    for (var i = 0; i < len; i++) {
                        if (obj.source[i].id != key.source[i].id) {
                            bool = false;
                            return true;
                        }
                    }
                } else {
                    bool = false;
                    return true;
                }
                bool = true;
                return true;
            }
        });
    }
    return bool;
}

function onWindowResize() {
    $("#historyTable").parents(".fixed-table-container").css("height", ($(window).height() - 280) + "px");
}

function exitApp() {
    var modal = $.scojs_confirm({
        content: '是否确定退出应用?',
        cssClass: 'system-font modal-class',
        action: function() {
            baseWindow.quitApp();
        }
    });
    modal.show();
}

function showConfirm(info, enterCallback, cancelCallback) {
    bootbox.dialog({
        message: info,
        buttons: {
            cancel: {
                label: "取消",
                className: "btn-default",
                callback: cancelCallback
            },
            success: {
                label: "确定",
                className: "btn-danger",
                callback: enterCallback
            }
        }
    });
}
