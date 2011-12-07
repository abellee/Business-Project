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
	import view.FloatPanel;
	import flash.display.Shape;

	import delegates.IUIDressControllerDelegate;

	import factory.ButtonFactory;
	import factory.StaticAssets;

	import fl.controls.Button;

	import global.FontFormat;
	import global.Global;

	import view.BodyInterface;
	import view.DressInterface;
	import view.ScreenShotInterface;

	import com.kge.containers.HGroup;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * 试衣间项目
	 */
	[SWF(backgroundColor="#000000", frameRate="30", width="1002", height="600")];
	public class FittingRoom extends Sprite implements IUIDressControllerDelegate, IUIView {
		/**
		 * 换装界面
		 */
		private var dressInterface : DressInterface;
		/**
		 * 身体调整界面
		 */
		private var bodyInterface : BodyInterface;
		/**
		 * 截图界面
		 */
		private var screenShotInterface : ScreenShotInterface;
		/**
		 * 换装界面按钮
		 */
		private var dressButton : Button;
		/**
		 * 身体调整按钮
		 */
		private var bodyButton : Button;
		/**
		 * 截图界面按钮
		 */
		private var ssButton : Button;
		/**
		 * 按钮窗口
		 */
		private var topButtonGroup : HGroup;
		private var searchBtn : Button;
		private var dock : Sprite;
		private var leftBlackBar : Shape;
		private var rightBlackBar : Shape;
		
		private var clothesPanel:FloatPanel;
		private var trousersPanel:FloatPanel;

		public function FittingRoom() {
			init();

			loadBackgroundImage();
			listButtons();
			showDressInterface();
		}

		private function init() : void {
			Global.staticAssets = new StaticAssets();
			Global.fontStyle = new FontFormat();
		}

		private function listButtons() : void {
			if (!dressButton) dressButton = ButtonFactory.DressInterfaceButton();
			if (!bodyButton) bodyButton = ButtonFactory.BodyInterfaceButton();
			if (!ssButton) ssButton = ButtonFactory.ScreenShotInterfaceButton();
			if (!topButtonGroup) topButtonGroup = new HGroup();
			topButtonGroup.gap = 0;
			topButtonGroup.addChild(dressButton);
			topButtonGroup.addChild(bodyButton);
			topButtonGroup.addChild(ssButton);
			addChild(topButtonGroup);
			topButtonGroup.delegate = this;

			dock = new Sprite();
			dock.mouseChildren = false;
			dock.mouseEnabled = false;
			dock.addChild(new Bitmap(Global.staticAssets.bottomDock()));
			addChild(dock);
			dock.x = 0;
			dock.y = stage.stageHeight - dock.height;
			
			leftBlackBar = getBlackSideBar();
			leftBlackBar.scaleX = -1;
			addChild(leftBlackBar);
			leftBlackBar.x = leftBlackBar.width / 2 - 10;
			leftBlackBar.y = (stage.stageHeight - leftBlackBar.height) / 2 - 40;
			
			rightBlackBar = getBlackSideBar();
			addChild(rightBlackBar);
			rightBlackBar.x = stage.stageWidth - rightBlackBar.width / 2 + 10;
			rightBlackBar.y = (stage.stageHeight - rightBlackBar.height) / 2 - 40;
			
			if(!clothesPanel) clothesPanel = new FloatPanel(3);
			addChild(clothesPanel);
			clothesPanel.x = leftBlackBar.x;
			clothesPanel.y = leftBlackBar.y + 10;
			
			if(!trousersPanel) trousersPanel = new FloatPanel(3);
			addChild(trousersPanel);
			trousersPanel.x = clothesPanel.x;
			trousersPanel.y = clothesPanel.y + clothesPanel.height + 10;
		}

		private function getBlackSideBar() : Shape {
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x000000, .5);
			shape.graphics.drawRoundRect(0, 0, 40, 470, 20);
			shape.graphics.endFill();
			return shape;
		}

		public function changingFinished(_view : UIView) : void {
			_view.x = (stage.stageWidth - _view.width) / 2;
			_view.y = 10;
		}

		private function loadBackgroundImage() : void {
		}

		private function showDressInterface() : void {
			if (!dressInterface) dressInterface = new DressInterface();
			addChild(dressInterface);
		}

		public function dressClicked() : void {
			trace("clicked");
		}
	}
}