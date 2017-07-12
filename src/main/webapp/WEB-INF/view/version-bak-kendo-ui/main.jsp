<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath }/kendo-ui/examples/content/shared/styles/examples-offline.css" rel="stylesheet"> 
<link href="${pageContext.request.contextPath }/kendo-ui/styles/kendo.common.min.css" rel="stylesheet"> 
<link href="${pageContext.request.contextPath }/kendo-ui/styles/kendo.rtl.min.css" rel="stylesheet"> 
<link href="${pageContext.request.contextPath }/kendo-ui/styles/kendo.default.min.css" rel="stylesheet"> 
<link href="${pageContext.request.contextPath }/kendo-ui/styles/kendo.dataviz.min.css" rel="stylesheet"> 
<link href="${pageContext.request.contextPath }/kendo-ui/styles/kendo.dataviz.default.min.css" rel="stylesheet"> 
<script src="${pageContext.request.contextPath }/kendo-ui/js/jquery.min.js"></script> 
<script src="${pageContext.request.contextPath }/kendo-ui/js/kendo.all.min.js"></script> 
<script src="${pageContext.request.contextPath }/kendo-ui/examples/content/shared/js/console.js"></script>
<title>Kendo-UI 用户列表展示页面</title> 
<script type="text/javascript">
	var viewModel = kendo.observable({
		model : {},
		createFunction : function() {
			$('#Grid').data('kendoGrid').addRow();
		},
		saveFunction : function() {
			$('#Grid').data('kendoGrid').saveChanges();
		},
		queryResource : function(e) {
			$('#Grid').data('kendoGrid').dataSource.page(1);
		},
        resetForm    : function (e) {
            var formData = viewModel.model.toJSON();
            for (var k in formData) {
                viewModel.model.set(k, null);
            }
        }
	});
</script>
</head>
<body>
<div id="page-content">
	<!-- <div class="pull-left" id="toolbar-btn" style="padding-bottom: 10px;">
		<span class="btn btn-primary k-grid-add" style="float: left; margin-right: 5px;" data-bind="click:createFunction">新增</span>
		<span class="btn btn-success k-grid-save-changes" data-bind="click:saveFunction" style="float: left; margin-right: 5px;">保存</span>
	    <span onclick="deleteData()" class="btn btn-danger"style="float: left;">删除</span>
	</div>
	<script>
		kendo.bind($('#toolbar-btn'), viewModel);
	</script>
	</div> -->
	
	<div style="clear: both">
		<div id="Grid"></div>
	</div>
		
	<script type="text/javascript">
	    var BaseUrl = '${base.contextPath}', _locale = '${base.locale}';
		dataSource = new kendo.data.DataSource({
			transport : {
				read : {
					url : BaseUrl + "/study/course/query",
					type : "POST",
					dataType : "json"
				},
				update : {
					url : BaseUrl + "/study/course/submit",
					type : "POST",
					contentType : "application/json"
				},
				destroy : {
					url : BaseUrl + "/study/course/remove",
					type : "POST",
					contentType : "application/json"
				},
				create : {
					url : BaseUrl + "/study/course/submit",
					type : "POST",
					contentType : "application/json"
				},
				parameterMap : function(options, type) {
					if (type !== "read" && options.models) {
						var datas = Hap.prepareSubmitParameter(options, type)
						return kendo.stringify(userList);
					} else if (type === "read") {
						return Hap.prepareQueryParameter(viewModel.model
								.toJSON(), options)
					}
				}
			},
			batch : true,
			serverPaging : true,
			pageSize : 10,
			schema : {
				data : 'rows',
				total : 'total',
				model : {
					id : "id",
					fields : {}
				}
			}
		});

		$("#Grid").kendoGrid({
			dataSource: {
                type: "odata",
                transport: {
                    read: "userList"
                },
                pageSize: 20
            },
			height : '100%',
			resizable : true,
			scrollable : true,
			navigatable : false,
			selectable : 'multiple, rowbox',
			pageable : {
				pageSizes : [ 5, 10, 20, 50 ],
				refresh : true,
				buttonCount : 5
			},
			columns : [ {
				field : "id",
				title : '用户ID',
				width : 120
			},{
				field : "user_name",
				title : '用户名称',
				width : 120
			}, {
				field : "age",
				title : '用户年龄',
				width : 120
			}],
			editable : true
		});
	</script>
</body>
</html>