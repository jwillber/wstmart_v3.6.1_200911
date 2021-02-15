var mmg;
function initGrid(p){
    var h = WST.pageHeight();
    var cols = [
        {title:'分组名称', name:'groupName' ,width:300,sortable:true},
        {title:'排序号', name:'groupOrder' ,width:300,sortable:true},
        {title:'操作', name:'' ,width:100, align:'center', renderer: function(val,item,rowIndex){
            var h = "";
            h += "<a  class='btn btn-blue' onclick='javascript:getForEdit("+item['id']+")'><i class='fa fa-pencil'></i>编辑</a> ";
            h += "<a  class='btn btn-red' onclick='javascript:del(" + item['id'] + ")'><i class='fa fa-trash-o'></i>删除</a> ";
            return h;
        }}
    ];

    mmg = $('.mmg').mmGrid({height: h-85,indehxCol: true, cols: cols,method:'POST',
        url: WST.U('shop/shopmembergroups/pageQuery'), fullWidthRows: true, autoLoad: false,remoteSort: true,
        plugins: [
            $('#pg').mmPaginator({})
        ]
    });
    loadGrid(p);
}

function loadGrid(p){
	p=(p<=1)?1:p;
    mmg.load({groupName:$('#groupName2').val(),page:p});
}

function getForEdit(id){
	 var loading = WST.msg('正在获取数据，请稍后...', {icon: 16,time:60000});
     $.post(WST.U('shop/shopmembergroups/get'),{id:id},function(data,textStatus){
           layer.close(loading);
           var json = WST.toJson(data);
           if(json.id){
           	  WST.setValues(json);
              toEdit(json.id);
           }else{
           		WST.msg(json.msg,{icon:2});
           }
    });
}
function toEdit(id){
	if(id==0){
      title = "新增";
      
  }else{
      title = "编辑";
  }
var box = WST.open({title:title,type:1,content:$('#editBox'),area: ['500px', '250px'],
		btn:['确定','取消'],end:function(){$('#editBox').hide();},yes:function(){
		$('#editForm').submit();
	},cancel:function () {
            $('#editForm')[0].reset();
        },btn2: function() {
            $('#editForm')[0].reset();
        },});
	$('#editForm').validator({
        fields: {
            groupName: {
            	rule:"required;",
            	msg:{required:"分组名称不能为空"},
            	tip:"请输入分组名称",
            	ok:""
            }           
        },
       valid: function(form){
		        var params = WST.getParams('.ipt');
	                params.id = id;
	                var loading = WST.msg('正在提交数据，请稍后...', {icon: 16,time:60000});
	           		$.post(WST.U('shop/shopmembergroups/'+((id==0)?"add":"edit")),params,function(data,textStatus){
	           			  layer.close(loading);
	           			  var json = WST.toJson(data);
	           			  if(json.status=='1'){
	           			    	WST.msg("操作成功",{icon:1});
	           			    	$('#editBox').hide();
	           			    	$('#editForm')[0].reset();
	           			    	layer.close(box);
                              loadGrid(WST_CURR_PAGE);
	           			  }else{
	           			        WST.msg(json.msg,{icon:2});
	           			  }
	           		});

    	}

  });

}
//删除
function del(id){
	var c = WST.confirm({content:'您确定要删除该分组吗?',yes:function(){
		layer.close(c);
		var load = WST.load({msg:'正在删除，请稍后...'});
		$.post(WST.U('shop/shopmembergroups/del'),{id:id},function(data,textStatus){
			layer.close(load);
		    var json = WST.toJson(data);
		    if(json.status==1){
		    	WST.msg(json.msg,{icon:1});
                loadGrid(WST_CURR_PAGE);
		    }else{
		    	WST.msg(json.msg,{icon:2});
		    }
		});
	}});
}

//设置分组
function setGroup(){
   
}