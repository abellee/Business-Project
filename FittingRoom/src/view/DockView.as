package view {
	import flash.events.MouseEvent;
	import flash.display.Shape;

	import factory.ButtonFactory;

	import fl.controls.Button;

	import global.Global;

	import com.kge.core.UIView;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;

	/**
	 * @author Abel
	 */
	public class DockView extends UIView {
		private var dock : Sprite;
		private var backgroundFlipLeft : Button;
		private var backgroundFlipRight : Button;
		private var planView : PlanView;
		private var historyView : HistoryView;
		private var backgroundItem0 : UIView;
		private var backgroundItem1 : UIView;
		private var backgroundItem2 : UIView;

		public function DockView() {
			super();

			dock = new Sprite();
			dock.mouseChildren = false;
			dock.mouseEnabled = false;
			dock.addChild(new Bitmap(Global.staticAssets.bottomDock()));
			addChild(dock);

			backgroundFlipLeft = ButtonFactory.BackgroundFlipButtonLeft();
			backgroundFlipRight = ButtonFactory.BackgroundFlipButtonRight();
			addChild(backgroundFlipLeft);
			addChild(backgroundFlipRight);
			backgroundFlipLeft.x = 440;
			backgroundFlipLeft.y = 8;
			backgroundFlipRight.x = 545;
			backgroundFlipRight.y = 8;
			backgroundFlipLeft.addEventListener(MouseEvent.CLICK, onFlipLeftClick);
			backgroundFlipRight.addEventListener(MouseEvent.CLICK, onFlipRightClick);

			planView = new PlanView();
			addChild(planView);
			planView.x = 10;
			planView.y = -20;

			historyView = new HistoryView();
			addChild(historyView);
			historyView.x = 572;
			historyView.y = -20;

			backgroundItem0 = new UIView();
			var bg0 : Shape = drawRect(0xaaaaaa);
			backgroundItem0.addChild(bg0);
			bg0.x = - bg0.width / 2;
			bg0.y = - bg0.height;
			backgroundItem0.rotation = -15;
			addChild(backgroundItem0);
			backgroundItem0.filters = [getBitmapFilter()];
			backgroundItem0.x = backgroundFlipLeft.x + backgroundFlipLeft.width + 35;
			backgroundItem0.y = 17;
			
			backgroundItem2 = new UIView();
			var bg2 : Shape = drawRect(0xaaaaaa);
			backgroundItem2.addChild(bg2);
			bg2.x = - bg2.width / 2;
			bg2.y = - bg2.height;
			backgroundItem2.rotation = 15;
			addChild(backgroundItem2);
			backgroundItem2.filters = [getBitmapFilter()];
			backgroundItem2.x = backgroundFlipLeft.x + backgroundFlipLeft.width + 50;
			backgroundItem2.y = 17;
			
			backgroundItem1 = new UIView();
			var bg1 : Shape = drawRect(0xFFFFFF);
			backgroundItem1.addChild(bg1);
			bg1.x = - bg1.width / 2;
			bg1.y = - bg1.height;
			addChild(backgroundItem1);
			backgroundItem1.filters = [getBitmapFilter()];
			backgroundItem1.x = backgroundFlipLeft.x + backgroundFlipLeft.width + 43;
			backgroundItem1.y = 19;
		}

		private function onFlipRightClick(event : MouseEvent) : void {
		}

		private function onFlipLeftClick(event : MouseEvent) : void {
		}

		private function drawRect(color : Number) : Shape {
			var sp : Shape = new Shape();
			sp.graphics.beginFill(color, 1);
			sp.graphics.drawRect(0, 0, 40, 50);
			sp.graphics.endFill();
			return sp;
		}

		private function getBitmapFilter() : BitmapFilter {
			var color : Number = 0x000000;
			var alpha : Number = 0.8;
			var blurX : Number = 5;
			var blurY : Number = 5;
			var strength : Number = 1;
			var inner : Boolean = false;
			var knockout : Boolean = false;
			var quality : Number = BitmapFilterQuality.HIGH;

			return new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
		}
	}
}
