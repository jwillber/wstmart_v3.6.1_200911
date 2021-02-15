var mmg;
function initGrid(p){
    var h = WST.pageHeight();
    var cols = [
            {title:'银行名称', name:'bankName', width: 300,renderer:function(val,item,rowIndex){
                if(item['bankImg'] && item['bankImg']!=''){
                   return '<img src="'+WST.conf.RESOURCE_PATH+'/'+item['bankImg']+'" height="28px" />&nbsp;'+val;
                }
                return '<span style="margin-left:32px">'+val+'</span>';
            }},
            {title:'银行代码', name:'bankCode', width: 100},
            {title:'是否启用', name:'isShow', width: 30,renderer: function(val,item,rowIndex){
              return '<input type="checkbox" '+((item['isShow']==1)?"checked":"")+' name="isShow2" lay-skin="switch" lay-filter="isShow2" data="'+item['bankId']+'" lay-text="显示|隐藏">';

            }},
            {title:'操作', name:'' ,width:170, align:'center', renderer: function(val,item,rowIndex){
                var h = "";
                if(WST.GRANT.YHGL_02)h += "<a  class='btn btn-blue' onclick='javascript:getForEdit("+item['bankId']+")'><i class='fa fa-pencil'></i>修改</a> ";
                if(WST.GRANT.YHGL_03)h += "<a  class='btn btn-red' onclick='javascript:toDel(" + item['bankId'] + ")'><i class='fa fa-trash-o'></i>删除</a> ";
                return h;
            }}
            ];
 
    mmg = $('.mmg').mmGrid({height: h-89,indexCol: true, cols: cols,method:'POST',
        url: WST.U('admin/banks/pageQuery'), fullWidthRows: true, autoLoad: false,
        plugins: [
            $('#pg').mmPaginator({})
        ]
    });
    mmg.on('loadSuccess',function(){
      layui.form.render('','gridForm');
        layui.form.on('switch(isShow2)', function(data){
            var id = $(this).attr("data");
            if(this.checked){
            toggleIsShow(0,id);
        }else{
            toggleIsShow(1,id);
        }
        });
    })
    loadGrid(p)
}
function toggleIsShow(t,v){
  if(!WST.GRANT.DQGL_02)return;
    var loading = WST.msg('正在提交数据，请稍后...', {icon: 16,time:60000});
      $.post(WST.U('admin/banks/editiIsShow'),{id:v,isShow:t},function(data,textStatus){
        layer.close(loading);
        var json = WST.toAdminJson(data);
        if(json.status=='1'){
            WST.msg(json.msg,{icon:1});
            loadGrid(WST_CURR_PAGE);
        }else{
            WST.msg(json.msg,{icon:2});
        }
    });
}
function loadGrid(p){
    p=(p<=1)?1:p;
    mmg.load({page:p});
}
function toDel(id){
	var box = WST.confirm({content:"您确定要删除该记录吗?",yes:function(){
	           var loading = WST.msg('正在提交数据，请稍后...', {icon: 16,time:60000});
	           	$.post(WST.U('admin/banks/del'),{id:id},function(data,textStatus){
	           			  layer.close(loading);
	           			  var json = WST.toAdminJson(data);
	           			  if(json.status=='1'){
	           			    	WST.msg("操作成功",{icon:1});
	           			    	layer.close(box);
                              loadGrid(WST_CURR_PAGE);
	           			  }else{
	           			    	WST.msg(json.msg,{icon:2});
	           			  }
	           		});
	            }});
}

function getForEdit(id){
	 var loading = WST.msg('正在获取数据，请稍后...', {icon: 16,time:60000});
     $.post(WST.U('admin/banks/get'),{id:id},function(data,textStatus){
           layer.close(loading);
           var json = WST.toAdminJson(data);
           if(json.bankId){
           		WST.setValues(json);
              $('#isShow')[0].checked = (json.isShow==1);
              layui.form.render();
              $('#preview').empty();
              if(json.bankImg && json.bankImg!='')$('#preview').html('<img src="'+WST.conf.RESOURCE_PATH+'/'+json.bankImg+'" height="30"  />');
           		toEdit(json.bankId);
           }else{
           		WST.msg(json.msg,{icon:2});
           }
    });
}
function initUpload(){
  //文件上传
  WST.upload({
      pick:'#bankImgPicker',
      formData: {dir:'banks'},
      accept: {extensions: 'gif,jpg,jpeg,png',mimeTypes: 'image/jpg,image/jpeg,image/png,image/gif'},
      callback:function(f){
        var json = WST.toAdminJson(f);
        if(json.status==1){
          $('#uploadMsg').empty().hide();
          $('#bankImg').val(json.savePath+json.thumb);
          $('#preview').html('<img src="'+WST.conf.RESOURCE_PATH+'/'+json.savePath+json.thumb+'" height="30" />');
        }else{
            WST.msg(json.msg,{icon:2});
        }
    },
    progress:function(rate){
        $('#uploadMsg').show().html('已上传'+rate+"%");
    }
  });
}
var isInitUpload = false;
function resetBank(){
    $("#bankName").val("");
    $("#bankImg").val("");
    $("#preview").empty();
}
function toEdit(id){
	if(id==0){
      title = "新增";
      resetBank();
  }else{
      title = "编辑";
  }
  if(!isInitUpload){
     isInitUpload = true;
     initUpload();
  }
	var box = WST.open({title:title,type:1,content:$('#bankBox'),area: ['650px', '380px'],
		btn:['确定','取消'],end:function(){$('#bankBox').hide();},yes:function(){
		$('#bankForm').submit();
	},cancel:function () {
            resetBank();
        },btn2: function() {
            resetBank();
        },});
	$('#bankForm').validator({
        fields: {
            bankName: {
            	rule:"required;",
            	msg:{required:"银行名称不能为空"},
            	tip:"请输入银行名称",
            	ok:""
            }           
        },
       valid: function(form){
		        var params = WST.getParams('.ipt');
	                params.bankId = id;
	                var loading = WST.msg('正在提交数据，请稍后...', {icon: 16,time:60000});
	           		$.post(WST.U('admin/banks/'+((id==0)?"add":"edit")),params,function(data,textStatus){
	           			  layer.close(loading);
	           			  var json = WST.toAdminJson(data);
	           			  if(json.status=='1'){
	           			    	WST.msg("操作成功",{icon:1});
	           			    	$('#bankBox').hide();
	           			    	$('#bankForm')[0].reset();
	           			    	layer.close(box);
                              loadGrid(WST_CURR_PAGE);
	           			  }else{
	           			        WST.msg(json.msg,{icon:2});
	           			  }
	           		});

    	}

  });

}