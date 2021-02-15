<?php
namespace wstmart\admin\model;
use wstmart\admin\validate\Banks as validate;
use think\Db;
/**
 * ============================================================================
 * WSTMart多用户商城
 * 版权所有 2016-2066 广州商淘信息科技有限公司，并保留所有权利。
 * 官网地址:http://www.wstmart.net
 * 交流社区:http://bbs.shangtao.net
 * 联系QQ:153289970
 * ----------------------------------------------------------------------------
 * 这不是一个自由软件！未经本公司授权您只能在不用于商业目的的前提下对程序代码进行修改和使用；
 * 不允许对程序代码以任何形式任何目的的再发布。
 * ============================================================================
 * 银行业务处理
 */
class Banks extends Base{
	protected $pk = 'bankId';
	/**
	 * 分页
	 */
	public function pageQuery(){
		return $this->where('dataFlag',1)->field('bankId,bankName,bankCode,bankImg,isShow')->order('bankId desc')->paginate(input('limit/d'));
	}
	public function getById($id){
		return $this->get(['bankId'=>$id,'dataFlag'=>1]);
	}
	/**
	 * 列表
	 */
	public function listQuery(){
		return $this->where(['dataFlag'=>1,'isShow'=>1])->field('bankId,bankName,bankImg')->select();
	}
	/**
	 * 新增
	 */
	public function add(){
		$data = ['bankName'=>input('post.bankName'),'bankImg'=>input('post.bankImg'),'bankCode'=>input('post.bankCode'),
				 'createTime'=>date('Y-m-d H:i:s'),'isShow'=>input('post.isShow')];
		$validate = new validate();
		Db::startTrans();
		try{
			if(!$validate->scene('add')->check($data))return WSTReturn($validate->getError());
			$result = $this->allowField(['bankName','bankImg','bankCode','createTime','isShow'])->save($data);
	        if(false !== $result){
	        	$bankId = $this->bankId;
	        	WSTUseResource(1, $bankId, $data['bankImg']);
	        	cache('WST_BANKS',null);
	        	Db::commit();
	        	return WSTReturn("新增成功", 1);
	        }else{
	        	return WSTReturn($this->getError(),-1);
	        }
		}catch (\Exception $e) {
            Db::rollback();
            return WSTReturn('新增失败',-1);
        }

	}
    /**
	 * 编辑
	 */
	public function edit(){
		$bankId = input('post.bankId/d',0);
		$validate = new validate();
		$bankImg = input('post.bankImg');
		Db::startTrans();
		try{
			WSTUseResource(1, $bankId, $bankImg,'banks','bankImg');
			if(!$validate->scene('edit')->check(['bankName'=>input('post.bankName'),'bankImg'=>$bankImg]))return WSTReturn($validate->getError());
		    $result = $this->allowField(['bankName','bankCode','bankImg','isShow'])->save(['bankName'=>input('post.bankName'),'bankCode'=>input('post.bankCode'),'bankImg'=>$bankImg,'isShow'=>input('post.isShow')],['bankId'=>$bankId]);
	        if(false !== $result){
	        	cache('WST_BANKS',null);
	        	Db::commit();
	        	return WSTReturn("编辑成功", 1);
	        }else{
	        	return WSTReturn($this->getError(),-1);
	        }
		}catch (\Exception $e) {
            Db::rollback();
            return WSTReturn('编辑失败',-1);
        }

	}
	/**
	 * 删除
	 */
    public function del(){
	    $id = input('post.id/d',0);
		$data = [];
		$data['dataFlag'] = -1;
	    $result = $this->update($data,['bankId'=>$id]);
        if(false !== $result){
        	cache('WST_BANKS',null);
        	return WSTReturn("删除成功", 1);
        }else{
        	return WSTReturn($this->getError(),-1);
        }
	}

	/**
	 * 显示是否显示/隐藏
	 */
	public function editiIsShow(){
		//获取子集
		$id = (int)input('post.id/d',0);
		$isShow = (int)input('post.isShow/d',0)?0:1;
		$result = $this->where("bankId = ".$id)->update(['isShow' => $isShow]);
		if(false !== $result){
            cache('WST_BANKS',null);
			return WSTReturn("操作成功", 1);
		}else{
			return WSTReturn($this->getError(),-1);
		}
	}

}
