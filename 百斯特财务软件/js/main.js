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

win.showDevTools("", false);

$(document).ready(init);

function init() {
    $("#exitBtn").on("click", exitApp);

    $(window).on("resize", onWindowResize);

    $("#keysModal").on("show.bs.modal", onKeysModalShow);
    $("#usersModal").on("show.bs.modal", onUsersModalShow);

    $("#addTableModal").on("show.bs.modal", onAddTableModalShow);
    $("#addKeyModal").on("show.bs.modal", onAddKeyModalShow);
    $("#addKeyModal").on("hide.bs.modal", onAddKeyModalHide);

    $("#createTableModal").on("show.bs.modal", onCreateTableModalShow);
    $("#tablesModal").on("show.bs.modal", onTablesModalShow);
    $("#editModal").on("show.bs.modal", onEditModalShow);

    $("#keysModal").on("hide.bs.modal", onModalHide);
    $("#usersModal").on("hide.bs.modal", onModalHide);
    $("#createTableModal").on("hide.bs.modal", onModalHide);
    $("#editModal").on("hide.bs.modal", onModalHide);
    $("#addTableModal").on("hide.bs.modal", onModalHide);

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
        columns: [{
            field: 'id',
            title: 'Item ID'
        }, {
            field: 'name',
            title: 'Item Name'
        }, {
            field: 'price',
            title: 'Item Price'
        }, {
            field: 'operate',
            title: 'Item Operate'
        }]
    }).on("load-success.bs.table", function(e, data) {

    }).on("load-error.bs.table", function(e, status) {

    });

    onWindowResize();
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
                                console.log(data);
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
                ].join('');;
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
    $('#usersTable').bootstrapTable({
        method: 'get',
        url: 'http://wenzhixin.net.cn/p/bootstrap-table/docs/data1.json',
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
            field: 'state',
            checkbox: true
        }, {
            field: 'id',
            title: 'Item ID'
        }, {
            field: 'name',
            title: 'Item Name'
        }, {
            field: 'price',
            title: 'Item Price'
        }, {
            field: 'operate',
            title: 'Item Operate'
        }]
    });
}

function onAddTableModalShow() {
    canClear = true;
    $("#typeSelect").select2({
        width: 300
    });
    $("#typeSelect").on("change", function(event) {
        if (event.val == 2 || event.val == 3) {
            $("#daysInput input").val("");
            $("#daysInput").show();
        } else {
            $("#daysInput").hide();
            $("#daysInput input").val("");
        }
    });
    $("#typeSelect").select2("val", 0);
    $("#typeSelect").trigger("change");

    $("#scopeSelect").select2({
        width: 300
    });
    $("#scopeSelect").on("change", function(event) {
        if (event.val == 1) {
            $("#userIds").select2({
                "tags": []
            });
            $("#userIds").select2("container").find("ul.select2-choices").sortable({
                containment: 'parent',
                start: function() {
                    $("#userIds").select2("onSortStart");
                },
                update: function() {
                    $("#userIds").select2("onSortEnd");
                }
            });
        } else {
            $("#userIds").select2("val", "");
            $("#userIds").select2("destroy");
        }
    });
    $("#scopeSelect").select2("val", 0);
    $("#scopeSelect").trigger("change");

    $("#isDisabled").bootstrapSwitch({
        onText: "是",
        offText: "否"
    });

    $("#cancelTableAdd").off("click");
    $("#cancelTableAdd").on("click", function() {
        if ((keys || $("#tableName").val() != "") && tableId == 0) {
            showConfirm("有数据未保存，是否确认退出?", function() {
                $("#addTableModal").modal("hide");
            });
        }
    });

    $("#tableName").removeAttr("readonly");
    $("#daysNum").removeAttr("readonly");
    $("#scopeSelect").select2("enable", true);
    $("#userIds").select2("enable", true);
    $("#typeSelect").select2("enable", true);
    $("#isDisabled").bootstrapSwitch("readonly", false);
    $("#tableName").val("");
    $("#daysNum").val("");
    $("#scopeSelect").select2("val", 0);
    $("#userIds").select2("val", "");
    $("#isDisabled").bootstrapSwitch("state", true);

    $("#addTableBtn").off("click");
    $("#addTableBtn").on("click", function() {
        console.log("message");
        if (!keys || !keys.length) {
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
        } else {
            ids = "";
        }
        var typeSelect = $("#typeSelect").select2("val");
        var daysNum = $("#daysNum").val();
        if (!typeSelect && typeSelect != 0 && typeSelect != 1 && daysNum == "") {
            $.scojs_message('请输入距离月初或月底的天数!', $.scojs_message.TYPE_ERROR);
            return;
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
        $("#daysNum").attr("readonly", "readonly");
        $("#scopeSelect").select2("enable", false);
        $("#userIds").select2("enable", false);
        $("#typeSelect").select2("enable", false);
        $("#isDisabled").bootstrapSwitch("readonly", true);

        var params = {
            disabled: disabled,
            daysNum: daysNum,
            ids: ids,
            tn: tableName,
            type: typeSelect,
            scope: scopeSelect,
            keys: keys
        }
        $.post(gui.App.manifest.server + gui.App.manifest.app + "/api/create_table_template", params, function(data) {
            ladda.stop();
            ladda = null;
            if (data.success) {
                if (data.added) {
                    $.scojs_message('添加报表成功!', $.scojs_message.TYPE_OK);
                    $("#addTableModal").modal("hide");
                } else {
                    $.scojs_message('添加报表失败，请稍候重试!', $.scojs_message.TYPE_ERROR);
                    $("#tableName").removeAttr("readonly");
                    $("#daysNum").removeAttr("readonly");
                    $("#scopeSelect").select2("enable", true);
                    $("#userIds").select2("enable", true);
                    $("#typeSelect").select2("enable", true);
                    $("#isDisabled").bootstrapSwitch("readonly", false);
                }
            } else {
                $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                $("#tableName").removeAttr("readonly");
                $("#daysNum").removeAttr("readonly");
                $("#scopeSelect").select2("enable", true);
                $("#userIds").select2("enable", true);
                $("#typeSelect").select2("enable", true);
                $("#isDisabled").bootstrapSwitch("readonly", false);
            }
        });
    });
}

function onAddKeyModalHide() {
    tempTags = [];
    $("#addTableModal").modal("show");
}

function onModalHide() {
    changingData = null;

    $('#keysTable').bootstrapTable("destroy");
    $('#tablesTable').bootstrapTable("destroy");

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
    $("#createTableSelect").select2({
        width: "100%"
    });
}

function onTablesModalShow() {
    window.tablesTableControllEvent = {
        "click .edit": function(e, value, row, index) {
            
        },
        "click .remove": function(e, value, row, index) {
            showConfirm("是否确认删除该报表模板？", function(){
                alert("enter");
            });
        }
    }
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
            field: 'type',
            title: '报表类型',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                switch (value) {
                    case 0:
                        return "无";
                        break;
                    case 1:
                        return "每天";
                        break;
                    case 2:
                        return "月底";
                        break;
                    case 3:
                        return "月初";
                        break;
                }
            }
        }, {
            field: 'days',
            title: '天数(天)',
            halign: "center",
            align: "center",
            valign: "middle"
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
                    '</a>',
                    '<a class="remove ml10" href="javascript:void(0)" title="删除">',
                    '<i class="glyphicon glyphicon-remove"></i>',
                    '</a>'
                ].join('');;
            },
            events: tablesTableControllEvent
        }]
    });
}

function onAddKeyModalShow() {
    canClear = false;
    $("#addTableModal").modal("hide");
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
        }
    });
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

    $('#addKeyTable').bootstrapTable({
        method: "get",
        url: gui.App.manifest.server + gui.App.manifest.app + "/api/keys_by_tid?tid=" + tableId,
        sidePagination: "server",
        cache: false,
        height: 200,
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
                if (row.data_source) {
                    return row.data_source[0].source_key.table_template.table_name;
                }
            }
        }, {
            field: "data_source",
            title: '数据源字段',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                if (row.data_source) {
                    return row.data_source[0].source_key.key_template.key_name;
                }
            }
        }, {
            field: "remark",
            title: '备注',
            halign: "center",
            align: "center",
            valign: "middle"
        }]
    });
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
        obj.remark = $("#addKeyRemark").val();
        if (existInKeys(obj)) {
            $.scojs_message('已有完全相同的字段存在!', $.scojs_message.TYPE_ERROR);
            return;
        }
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
    });
}

function existInKeys(obj) {
    var bool = false;
    if (keys) {
        keys.forEach(function(key) {
            if (key.source_table_template_id == obj.source_table_template_id && key.source_key_id == obj.source_key_id && obj.key_template_id == key.key_template_id && obj.value_type == key.value_type) {
                if (obj.source.length == key.source.length) {
                    var len = obj.source.length;
                    for (var i = 0; i < len; i++) {
                        if (obj.source[i].id != key.source[i].id) {
                            bool = false;
                            return true;
                        }
                    }
                    bool = true;
                    return true;
                }
            }
        });
    }
    return bool;
}

function onEditModalShow() {
    $('#editTable').bootstrapTable({
        method: 'get',
        url: 'http://192.168.2.100/data1.json',
        sidePagination: "server",
        height: 500,
        cache: false,
        striped: false,
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
        columns: [{
            field: 'id',
            title: 'Item ID',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'name',
            title: 'Item Name',
            halign: "center",
            align: "center",
            valign: "middle",
            formatter: function(value, row, index) {
                return '<input type="password" class="form-control" placeholder="请输入原密码">';
            }
        }, {
            field: 'price',
            title: 'Item Price',
            halign: "center",
            align: "center",
            valign: "middle"
        }, {
            field: 'operate',
            title: 'Item Operate',
            halign: "center",
            align: "center",
            valign: "middle"
        }]
    }).on("load-success.bs.table", function(e, data) {

    }).on("load-error.bs.table", function(e, status) {

    });
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
