package view {
	import factory.ButtonFactory;

	import fl.controls.Button;

	import global.Global;

	import com.kge.core.UIView;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author Abel
	 */
	public class DockView extends UIView {
		private var dock : Sprite;
		private var backgroundFlipLeft : Button;
		private var backgroundFlipRight : Button;
		private var planView:PlanView;
		private var historyView:HistoryView;

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
			
			planView = new PlanView();
			addChild(planView);
			planView.x = 10;
			planView.y = -20;
			
			historyView = new HistoryView();
			addChild(historyView);
			historyView.x = 572;
			historyView.y = -20;
		}
	}
}
