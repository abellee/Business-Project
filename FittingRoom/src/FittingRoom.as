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
 * 本人不会对任何项目相关的源代码、素材进行任何形式的外泄或传播
 * 如有任何人未经拥有所有权方授权同意使用或传播，与本人无关，一切后果自负！
 */
package {
	import com.kge.containers.HGroup;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;
	
	import config.Config;
	
	import controls.BodyView;
	import controls.DetailPanel;
	import controls.SearchConditionItem;
	import controls.SearchConditionPanel;
	
	import delegates.IUIDressControllerDelegate;
	
	import factory.ButtonFactory;
	import factory.StaticAssets;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	
	import global.FontFormat;
	import global.Global;
	
	import resource.Resource;
	
	import view.BodyInterface;
	import view.DockView;
	import view.DressInterface;
	import view.FloatPanel;
	import view.ScreenShotInterface;

	/**
	 * 试衣间项目
	 */
	[SWF(backgroundColor="#000000", frameRate="30", width="1002", height="600")]
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
		private var backgroundPath : String = "background0.jpg";
		private var clothes : String = "a.jpg";
		private var loader : Loader = new Loader();
		private var helpButton : Button;
		private var searchConditionPanel : SearchConditionPanel;
		public var bodyView : BodyView = new BodyView();
		private var curSearchingPanel : FloatPanel;
		private var detailPanel:DetailPanel;

		public function FittingRoom() {
			instance = this;

			init();

			loadBackgroundImage();
			listButtons();
			showDressInterface();
			
			detailPanel = new DetailPanel();
		}
		
		public function showSearchPanel(fp:FloatPanel):void
		{
			if(curSearchingPanel && curSearchingPanel != fp){
				removeSearchPanel();
			}else{
				if(searchConditionPanel){
					removeSearchPanel();
					return;
				}
			}
			curSearchingPanel = fp;
			searchConditionPanel = new SearchConditionPanel(fp._dir);
			addChild(searchConditionPanel);
			if(fp._dir == "right"){
				searchConditionPanel.x = fp.x + 260;
			}else{
				searchConditionPanel.x = fp.x - 205;
			}
			searchConditionPanel.y = fp.y + 20;
		}
		
		public function openDetailPanel(bitmap:Bitmap, id:String, name:String, price:Number, colors:Vector.<Number>, pos:String):void
		{
			addChild(detailPanel);
			detailPanel.addProductImage(bitmap);
			detailPanel.productIdAndName(id, name);
			detailPanel.setPrice(price);
			detailPanel.setColors(colors);
			switch(pos){
				case "lt":
					detailPanel.x = 260;
					detailPanel.y = 50;
					break;
				case "lb":
					detailPanel.x = 260;
					detailPanel.y = 200;
					break;
				case "rt":
					detailPanel.x = 557;
					detailPanel.y = 50;
					break;
				case "rb":
					detailPanel.x = 557;
					detailPanel.y = 200;
					break;
			}
		}
		
		public function closeDetailPanel():void
		{
			if(detailPanel && this.contains(detailPanel)) this.removeChild(detailPanel);
		}
		
		private function init() : void {
			Global.staticAssets = new StaticAssets();
			Global.fontStyle = new FontFormat();
			Global.connection.objectEncoding = ObjectEncoding.AMF3;
			Global.connection.connect(Config.instance.amfphpURL);
			
			var so:SharedObject = SharedObject.getLocal("fittingRoom");
			if(so && so.data){
				if(so.data.sex) Global.curSex = so.data.sex;
			}
		}

		private function listButtons() : void {
			dressInterface = new DressInterface();
			bodyInterface = new BodyInterface();
			screenShotInterface = new ScreenShotInterface();

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

			var turnButton : Button = ButtonFactory.TurnArroundButton();
			var resumeButton : Button = ButtonFactory.ResumeButton();
			var zoomOutButton : Button = ButtonFactory.ZoomOutButton();
			var zoomInButton : Button = ButtonFactory.ZoomInButton();
			var zoomClothesButton : Button = ButtonFactory.ZoomClothesButton();
			var zoomTrousersButton : Button = ButtonFactory.ZoomTrousersButton();
			var zoomShoeButton : Button = ButtonFactory.ZoomShoeButton();

			helpButton = ButtonFactory.HelpButton();
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
			
			addChildAt(bodyView, 0);
			bodyView.width = 200;
			bodyView.height = 400;
			bodyView.x = 375;
			bodyView.y = 120;
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
			removeSearchPanel();
			closeDetailPanel();
			curButton = button;
			if (button == dressButton) {
				screenShotInterface.visible = false;
				dressInterface.visible = false;
				dockView.visible = false;
				miniButtonGroup.visible = true;
				leftBlackBar.visible = true;
				rightBlackBar.visible = true;
				helpButton.visible = true;
				showBodyInterface();
			} else if (button == bodyButton) {
				bodyInterface.visible = false;
				screenShotInterface.visible = false;
				dockView.visible = true;
				miniButtonGroup.visible = true;
				leftBlackBar.visible = true;
				rightBlackBar.visible = true;
				helpButton.visible = true;
				showDressInterface();
			} else if (button == ssButton) {
				dressInterface.visible = false;
				bodyInterface.visible = false;
				dockView.visible = false;
				miniButtonGroup.visible = false;
				leftBlackBar.visible = false;
				rightBlackBar.visible = false;
				helpButton.visible = false;
				showScreenShotInterface();
			}
		}

		private function getBlackSideBar() : Shape {
			var shape : Shape = new Shape();
			shape.graphics.beginFill(0x000000, .5);
			shape.graphics.drawRoundRect(0, 0, 40, 490, 20);
			shape.graphics.endFill();
			return shape;
		}
		
		public function removeSearchPanel():void
		{
			if(searchConditionPanel){
				if(this.contains(searchConditionPanel)){
					this.removeChild(searchConditionPanel);
					searchConditionPanel = null;
				}
			}
		}

		public function changingFinished(_view : UIView) : void {
			_view.x = (stage.stageWidth - _view.width) / 2;
			_view.y = 10;
		}

		private function loadBackgroundImage() : void {
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, backgroundLoadComplete);
			loader.load(new URLRequest(backgroundPath));
		}

		private function backgroundLoadComplete(event : Event) : void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, backgroundLoadComplete);
			addChildAt(loader.content, 0);
		}

		private function showDressInterface() : void {
			if (!dressInterface) dressInterface = new DressInterface();
			addChild(dressInterface);
			dressInterface.visible = true;
			dressInterface.x = leftBlackBar.x;
			dressInterface.y = 0;
		}

		private function showBodyInterface() : void {
			if (!bodyInterface) bodyInterface = new BodyInterface();
			addChild(bodyInterface);
			bodyInterface.visible = true;
			bodyInterface.x = dressInterface.x;
			bodyInterface.y = dressInterface.y;
		}

		private function showScreenShotInterface() : void {
			if(!screenShotInterface) screenShotInterface = new ScreenShotInterface();
			addChild(screenShotInterface);
			screenShotInterface.visible = true;
			screenShotInterface.x = dressInterface.x;
			screenShotInterface.y = dressInterface.y;
		}

		public function dressClicked() : void {
			trace("clicked");
		}
	}
}