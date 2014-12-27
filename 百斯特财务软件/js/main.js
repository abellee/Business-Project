var gui = require("nw.gui");
var win = gui.Window.get();
var md5 = require('MD5');
var ladda;
var baseWindow;
var ladda;

var changingData;
var changingIndex;

win.showDevTools("", false);

$(document).ready(init);

function init(){
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
        method: 'get',
        url: 'http://192.168.2.100/data1.json',
        cache: false,
        striped: false,
        pagination: true,
        pageSize: 100,
        search: true,
        pageList:[],
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function(){
        	return "正在加载，请稍候...";
        },
        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function(){
        	return "搜索...";
        },
        formatNoMatches: function(){
        	return "当前无任何数据...";
        },
        formatRefresh: function(){
        	return "刷新";
        },
        formatRecordsPerPage: function(pageNumber){
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
    }).on("load-success.bs.table", function(e, data){
    	
    }).on("load-error.bs.table", function(e, status){
    	
    });

    onWindowResize();
}

function onKeysModalShow(){
	window.keysTemplateAddControllEvent = {
		"click .edit": function(e, value, row, index){
			changingData = row;
			changingIndex = index;
			$("#submitBtn span").text("修改字段");
			$("#keyTemplateName").val(row.key_name);
			$("#keyTemplateRemark").val(row.remark);
		},
		"click .remove": function(e, value, row, index){
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
			      	var param = {id: changingData.id};
			      	$.post(path, param, function(data){
			      		console.log(data);
			      		if(data.success && data.deleted){
			      			$('#keysTable').bootstrapTable("refresh", {slient: true});
			      			$("#resetBtn").trigger("click");
			      			$.scojs_message('删除成功!', $.scojs_message.TYPE_OK);
			      		}else{
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
        formatLoadingMessage: function(){
        	return "正在加载，请稍候...";
        },
        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function(){
        	return "搜索...";
        },
        formatNoMatches: function(){
        	return "当前无任何数据...";
        },
        formatRefresh: function(){
        	return "刷新";
        },
        formatRecordsPerPage: function(pageNumber){
        	return pageNumber + "条/页";
        },
        columns: [{
            field: 'state',
            checkbox: true,
	        halign: "center",
	        align: "center"
        }, {
            field: 'key_name',
            title: '字段名称',
	        halign: "center",
	        align: "center"
        }, {
            field: 'remark',
            title: '备 注',
	        halign: "center",
	        align: "center"
        }, {
            field: 'created_at',
            title: '创建时间',
	        halign: "center",
	        align: "center"
        }, {
            field: 'updated_at',
            title: '最近更新时间',
	        halign: "center",
	        align: "center"
        },{
        	title: "操 作",
        	formatter: function(){
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

	$("#resetBtn").on("click", function(){
		changingData = null;
		$("#keyTemplateName").val("");
		$("#keyTemplateRemark").val("");
		$("#submitBtn span").text("添加字段");
	});

	$("#submitBtn span").text("添加字段");
	$("#keyTemplateName").val("");
	$("#keyTemplateRemark").val("");

	$("#submitBtn").on("click", function(){
		var keyName = $("#keyTemplateName").val();
		var keyRemark = $("#keyTemplateRemark").val();
		keyName = $.trim(keyName);
		keyRemark = $.trim(keyRemark);
		if(keyName == ""){
			$.scojs_message('字段名称不能为空!', $.scojs_message.TYPE_ERROR);
			return;
		}

		if(ladda) return;
		$("#keyTemplateName").attr("readonly", "readonly");
		$("#keyTemplateRemark").attr("readonly", "readonly");
		ladda = Ladda.create(this);
		ladda.start();
		var path = gui.App.manifest.server + gui.App.manifest.app + "/api/create_key_template";
		var param = {kn: keyName, rm: keyRemark};
		if(changingData){
			path = gui.App.manifest.server + gui.App.manifest.app + "/api/update_key_template";
			param.id = changingData.id;
		}
		$.post(path, param, function(data){
			ladda.stop();
			ladda = null;
			$("#keyTemplateName").removeAttr("readonly");
			$("#keyTemplateRemark").removeAttr("readonly");
			if(!data || !data.success){
				if(data && data.msg){
					$.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
				}else{
					$.scojs_message('操作失败，请稍候重试!', $.scojs_message.TYPE_ERROR);
				}
			}else{
				if(data.added){
					$("#keyTemplateName").val("");
					$("#keyTemplateRemark").val("");
					$('#keysTable').bootstrapTable("refresh", {slient: true});
					$.scojs_message('添加成功!', $.scojs_message.TYPE_OK);
					return;
				}else if(data.update){
					$("#keyTemplateName").val("");
					$("#keyTemplateRemark").val("");
					$('#keysTable').bootstrapTable("updateRow", {silent: true, index: changingIndex, row: data.data});
					$("#resetBtn").trigger("click");
					$.scojs_message('更新成功!', $.scojs_message.TYPE_OK);
					return;
				}
				$.scojs_message('操作失败，请稍候重试!', $.scojs_message.TYPE_ERROR);
			}
		});
	});
}

function onUsersModalShow(){
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
        formatLoadingMessage: function(){
        	return "正在加载，请稍候...";
        },
        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function(){
        	return "搜索...";
        },
        formatNoMatches: function(){
        	return "当前无任何数据...";
        },
        formatRefresh: function(){
        	return "刷新";
        },
        formatRecordsPerPage: function(pageNumber){
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

function onAddTableModalShow(){
	$("#userIds").select2({
		"tags":["red", "blue"]
	});

	$("#isDisabled").bootstrapSwitch({
		onText: "是",
		offText: "否"
	});

	$("#userIds").select2("container").find("ul.select2-choices").sortable({
	    containment: 'parent',
	    start: function() { $("#userIds").select2("onSortStart"); },
	    update: function() { $("#userIds").select2("onSortEnd"); }
	});
}

function onAddKeyModalHide(){
	$("#addTableModal").modal("show");
}

function onModalHide(){
	changingData = null;
	$('#keysTable').bootstrapTable("destroy");
	$('body').removeClass('modal-open');
	$('.modal-backdrop').remove();
}

function onCreateTableModalShow(){
	$("#createTableSelect").select2({
		width: "100%"
	});
}

function onTablesModalShow(){
	$('#tablesTable').bootstrapTable({
        method: 'get',
        url: 'http://wenzhixin.net.cn/p/bootstrap-table/docs/data1.json',
        cache: false,
        height: 500,
        striped: false,
        pagination: true,
        pageSize: 20,
        search: true,
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function(){
        	return "正在加载，请稍候...";
        },
        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function(){
        	return "搜索...";
        },
        formatNoMatches: function(){
        	return "当前无任何数据...";
        },
        formatRefresh: function(){
        	return "刷新";
        },
        formatRecordsPerPage: function(pageNumber){
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

function onAddKeyModalShow(){
	$("#addTableModal").modal("hide");
	$("#selectKey").select2();
	$("#selectValueType").select2();
	$("#selectSourceTable").select2();
	$("#selectSourceKey").select2();

	$('#addKeyTable').bootstrapTable({
        cache: false,
        height: 200,
        striped: false,
        pagination: true,
        pageSize: 10,
        search: true,
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function(){
        	return "正在加载，请稍候...";
        },
        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function(){
        	return "搜索...";
        },
        formatNoMatches: function(){
        	return "当前无任何数据...";
        },
        formatRefresh: function(){
        	return "刷新";
        },
        formatRecordsPerPage: function(pageNumber){
        	return pageNumber + "条/页";
        },
        columns: [{
            field: 'state',
            checkbox: true
        }, {
            title: '字段名称'
        }, {
            title: '值类型'
        }, {
            title: '数据源表'
        }, {
            title: '数据源字段'
        }, {
            title: '备注'
        }]
    });
}

function onEditModalShow(){
	$('#editTable').bootstrapTable({
        method: 'get',
        url: 'http://192.168.2.100/data1.json',
        height: 500,
        cache: false,
        striped: false,
        search: true,
        pageList:[],
        showColumns: false,
        showRefresh: true,
        formatLoadingMessage: function(){
        	return "正在加载，请稍候...";
        },
        formatShowingRows: function (pageFrom, pageTo, totalRows) {
            return '显示 ' + pageFrom + ' 到 ' + pageTo + ' 共 ' + totalRows + ' 条';
        },
        formatSearch: function(){
        	return "搜索...";
        },
        formatNoMatches: function(){
        	return "当前无任何数据...";
        },
        formatRefresh: function(){
        	return "刷新";
        },
        formatRecordsPerPage: function(pageNumber){
        	return pageNumber + "条/页";
        },
        columns: [{
            field: 'id',
            title: 'Item ID'
        }, {
            field: 'name',
            title: 'Item Name',
            formatter: function(value, row, index){
            	return '<input type="password" class="form-control" placeholder="请输入原密码">';
            }
        }, {
            field: 'price',
            title: 'Item Price'
        }, {
            field: 'operate',
            title: 'Item Operate'
        }]
    }).on("load-success.bs.table", function(e, data){
    	
    }).on("load-error.bs.table", function(e, status){
    	
    });
}

function onWindowResize(){
	$("#historyTable").parents(".fixed-table-container").css("height", ($(window).height() - 280) + "px");
}

function exitApp(){
	var modal = $.scojs_confirm({
		content: '是否确定退出应用?',
		cssClass: 'system-font modal-class',
		action: function(){
			baseWindow.quitApp();
		}
	});
	modal.show();
}