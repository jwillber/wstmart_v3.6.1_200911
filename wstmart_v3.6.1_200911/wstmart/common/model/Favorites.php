<?php
namespace wstmart\common\model;
use think\Db;
use wstmart\common\model\Shops;
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
 * 收藏类
 */
class Favorites extends Base{
	protected $pk = 'favoriteId';
	/**
	 * 关注的商品列表
	 */
	public function listGoodsQuery($userId = 0){
		$pagesize = input("param.pagesize/d");
		$userId = ($userId>0)?$userId:(int)session('WST_USER.userId');
		$page = Db::name("favorites")->alias('f')
    	->join('__GOODS__ g','g.goodsId = f.goodsId','left')
    	->join('__SHOPS__ s','s.shopId = g.shopId','left')
    	->field('f.favoriteId,f.goodsId,g.goodsName,g.goodsImg,g.shopPrice,g.marketPrice,g.saleNum,g.appraiseNum,s.shopId,s.shopName')
    	->where(['f.userId'=> $userId])
    	->order('f.favoriteId desc')
    	->paginate($pagesize)->toArray();
		foreach ($page['data'] as $key =>$v){
			//认证
			$shop = new Shops();
			$accreds = $shop->shopAccreds($v["shopId"]);
			$page['data'][$key]['accreds'] = $accreds;
		}
		return $page;
	}
	/**
	 * 取消关注
	 */
	public function del($userId = 0){
		$id = input("param.id");
		$userId = ($userId>0)?$userId:(int)session('WST_USER.userId');
		$ids = explode(',',$id);
		if(empty($ids))return WSTReturn("取消失败", -1);
		$rs = $this->where([['favoriteId','in',$ids],['userId','=',$userId]])->delete();
		if(false !== $rs){
			return WSTReturn("取消成功", 1);
		}else{
			return WSTReturn($this->getError(),-1);
		}
	}


	/**
	 * 新增关注
	 */
	public function add($userId = 0){
	    $id = input("param.id/d");
		$userId = ($userId>0)?$userId:(int)session('WST_USER.userId');
		if($userId==0)return WSTReturn('关注失败，请先登录',-2);
		//判断记录是否存在
		$isFind = false;
		$c = Db::name('goods')->where(['goodsStatus'=>1,'dataFlag'=>1,'goodsId'=>$id])->count();
		$isFind = ($c>0);
		if(!$isFind)return WSTReturn("关注失败，无效的关注对象", -1);
		$data = [];
		$data['userId'] = $userId;
		$data['goodsId'] = $id;
		//判断是否已关注
		$rc = $this->where($data)->count();
		if($rc>0)return WSTReturn("关注成功", 1);
		$data['createTime'] = date('Y-m-d H:i:s');
		$rs = $this->save($data);
		if(false !== $rs){
			return WSTReturn("关注成功", 1,['fId'=>$this->favoriteId]);
		}else{
			return WSTReturn($this->getError(),-1);
		}
	}
	/**
	 * 判断是否已关注
	 */
	public function checkFavorite($id,$uId=0){
		$userId = ($uId==0)?(int)session('WST_USER.userId'):$uId;
		$rs = $this->where(['userId'=>$userId,'goodsId'=>$id])->find();
		return empty($rs)?0:$rs['favoriteId'];
	}
	/**
	 * 关注数
	 */
	public function followNum($id){
		$rs = $this->where(['goodsId'=>$id])->count();
		return $rs;
	}
}
