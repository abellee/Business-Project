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
	import view.DockView;

	import flash.events.MouseEvent;

	import delegates.IUIDressControllerDelegate;

	import factory.ButtonFactory;
	import factory.StaticAssets;

	import fl.controls.Button;

	import global.FontFormat;
	import global.Global;

	import view.BodyInterface;
	import view.DressInterface;
	import view.FloatPanel;
	import view.ScreenShotInterface;

	import com.greensock.TweenLite;
	import com.kge.containers.HGroup;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;

	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * 试衣间项目
	 */
	[SWF(backgroundColor="#000000", frameRate="30", width="1002", height="600")];
	public class FittingRoom extends Sprite implements IUIDressControllerDelegate, IUIView {
		/**
		 * 换装界面
		 */
		private var dressInterface : DressInterface ;
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
		private var leftBlackBar : Shape;
		private var rightBlackBar : Shape;
		private var dockView : DockView;
		private var miniButtonGroup : HGroup;
		private var curButton : Button;
		public static var instance : FittingRoom = null;

		public function FittingRoom() {
			instance = this;

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
			dressInterface = new DressInterface();

			dockView = new DockView();
			addChild(dockView);
			dockView.x = 0;
			dockView.y = stage.stageHeight - dockView.height + 38;

			leftBlackBar = getBlackSideBar();
			leftBlackBar.scaleX = -1;
			addChild(leftBlackBar);
			leftBlackBar.x = leftBlackBar.width / 2 - 10;
			leftBlackBar.y = (stage.stageHeight - leftBlackBar.height) / 2 - 40;

			rightBlackBar = getBlackSideBar();
			addChild(rightBlackBar);
			rightBlackBar.x = stage.stageWidth - rightBlackBar.width / 2 + 10;
			rightBlackBar.y = (stage.stageHeight - rightBlackBar.height) / 2 - 40;

			addChild(dressInterface);
			dressInterface.x = leftBlackBar.x;
			dressInterface.y = 0;

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
			
			bodyButton.selected = true;
			curButton = bodyButton;

			dressButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			bodyButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			ssButton.addEventListener(MouseEvent.CLICK, onButtonClick);

			var helpButton : Button = ButtonFactory.HelpButton();
			var turnButton : Button = ButtonFactory.TurnArroundButton();
			var resumeButton : Button = ButtonFactory.ResumeButton();
			var zoomOutButton : Button = ButtonFactory.ZoomOutButton();
			var zoomInButton : Button = ButtonFactory.ZoomInButton();
			var zoomClothesButton : Button = ButtonFactory.ZoomClothesButton();
			var zoomTrousersButton : Button = ButtonFactory.ZoomTrousersButton();
			var zoomShoeButton : Button = ButtonFactory.ZoomShoeButton();

			addChild(helpButton);
			helpButton.x = 710;
			helpButton.y = 500;
			miniButtonGroup = new HGroup();
			miniButtonGroup.addChild(turnButton);
			miniButtonGroup.addChild(resumeButton);
			miniButtonGroup.addChild(zoomOutButton);
			miniButtonGroup.addChild(zoomInButton);
			miniButtonGroup.addChild(zoomClothesButton);
			miniButtonGroup.addChild(zoomTrousersButton);
			miniButtonGroup.addChild(zoomShoeButton);
			addChild(miniButtonGroup);
			miniButtonGroup.x = helpButton.x + helpButton.width + 5;
			miniButtonGroup.y = helpButton.y + 3;
		}

		private function onButtonClick(event : MouseEvent) : void {
			var button : Button = event.currentTarget as Button;
			if (curButton) {
				if (curButton == button) {
					curButton.selected = true;
					return;
				} else {
					curButton.selected = false;
				}
			}
			curButton = button;
			if (button == dressButton) {
			} else if (button == bodyButton) {
			} else if (button == ssButton) {
			}
		}

		private function getBlackSideBar() : Shape {
			var shape : Shape = new Shape();
			shape.graphics.beginFill(0x000000, .5);
			shape.graphics.drawRoundRect(0, 0, 40, 490, 20);
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