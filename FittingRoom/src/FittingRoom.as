/**
 * 试衣间项目
 * author:		Abel Lee（李金贝）
 * timestamp:	2011-11-01
 * 此项目一切所有权归 工合 所有
 * 包括项目所有源代码、素材等资源
 * 项目功能包括 试穿、模特身材微调、试穿记录、场景切换、数据搜索等等功能
 * 
 * 责任说明：
 * 此项目一切所有权归 工合 所有
 * 本人不会对任何项目相关的源代码、素材进入任何形式的外泄或传播
 * 如有任何人未经拥有所有权方授权同意使用或传播，与本人无关，一切后果自负！
 */
package {
	import flash.display.Sprite;
	
	[SWF(backgroundColor="#000000", frameRate="31", width="1000", height="600")];
	public class FittingRoom extends Sprite
	{
		public function FittingRoom()
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xff0000);
			sp.graphics.drawCircle(100, 100, 100);
			sp.graphics.endFill();
			addChild(sp);
			sp.x = 100;
			sp.y = 100;
			trace("hello");
		}
	}
}