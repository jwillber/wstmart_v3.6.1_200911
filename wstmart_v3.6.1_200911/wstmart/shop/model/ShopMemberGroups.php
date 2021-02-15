<?php
namespace wstmart\shop\model;
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
 * 商家会员业务类
 */
class ShopMemberGroups extends Base{
	/**
	 * 获取分页
	 */
	public function pageQuery(){
		$shopId = (int)session('WST_USER.shopId');
        return Db::name('shop_member_groups')->where('shopId',$shopId)->order('groupOrder asc,id desc')->paginate(input('limit/d'))->toArray();
    }
    /**
	 * 获取列表
	 */
	public function listQuery(){
		$shopId = (int)session('WST_USER.shopId');
       return Db::name('shop_member_groups')->where('shopId',$shopId)->order('groupOrder asc,id desc')->select();
    }
	/**
	 * 新增
	 */
	public function add(){
		$shopId = (int)session('WST_USER.shopId');
		$data = input('post.');
		if($data['groupName']=='')return WSTReturn('请输入分组名称');
		$data['groupOrder'] = (int)$data['groupOrder'];
		$data['shopId'] = $shopId;
		$result = $this->allowField(true)->save($data);
		if(false !== $result){
			return WSTReturn("新增成功", 1);
		}
        return WSTReturn('新增失败',-1);
	}
	
	/**
	 * 编辑
	 */
	public function edit(){
		$id = input('post.id/d');
		$data = input('post.');
		if($data['groupName']=='')return WSTReturn('请输入分组名称');
		$data['groupOrder'] = (int)$data['groupOrder'];
		$result = $this->allowField(['groupName','groupOrder'])->save($data,['id'=>$id]);
		if(false !== $result){
			return WSTReturn("修改成功", 1);
		}
        return WSTReturn('修改失败',-1);
	}

	/**
	 * 获取数据
	 */
	public function getById($id){
		$shopId = (int)session('WST_USER.shopId');
		return $this->where(['id'=>$id,'shopId'=>$shopId])->find();
	}
	
	/**
	 * 删除
	 */
	public function del(){
		$shopId = (int)session('WST_USER.shopId');
		$id = input('post.id/d');
		Db::startTrans();
        try{
			$result = $this->where(['id'=>$id,'shopId'=>$shopId])->delete();
			if(false !== $result){
				//清除用户分组
				Db::name('shop_members')->where(['groupId'=>$id,'shopId'=>$shopId])->update(['groupId'=>0]);
				Db::commit();
				return WSTReturn("删除成功", 1);
			}
        }catch (\Exception $e) {
            Db::rollback();
        }
        return WSTReturn('删除失败',-1);
	}
	
}
