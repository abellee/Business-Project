package view {
	import factory.ButtonFactory;

	import fl.controls.Button;

	import com.kge.containers.HGroup;
	import com.kge.core.UIView;

	import flash.display.Shape;
	import flash.events.MouseEvent;

	/**
	 * @author Abel
	 */
	public class HistoryView extends UIView {
		private var background : Shape;
		private var leftArrow : Button;
		private var rightArrow : Button;
		private var planTab0 : Button;
		private var cellGroup : HGroup;
		private var cells : Vector.<UIView> = new Vector.<UIView>();

		public function HistoryView() {
			super();

			drawBackground();

			leftArrow = ButtonFactory.PlanLeftArrow();
			rightArrow = ButtonFactory.PlanRightArrow();
			addChild(leftArrow);
			addChild(rightArrow);
			leftArrow.x = 8;
			leftArrow.y = (50 - leftArrow.height) / 2;
			rightArrow.x = 400;
			rightArrow.y = leftArrow.y;

			cellGroup = new HGroup();
			cellGroup.gap = 10;
			for (var i : int = 0; i < 7; i++) {
				var cell : UIView = new UIView();
				cell.addChild(ButtonFactory.Item());
				cells.push(cell);
				cellGroup.addChild(cell);
			}
			addChild(cellGroup);
			cellGroup.x = leftArrow.x + leftArrow.width + 11;
			cellGroup.y = (50 - cellGroup.height) / 2;

			planTab0 = ButtonFactory.PlanTabButton();
			planTab0.label = "历史记录";
			planTab0.selected = true;
			planTab0.mouseChildren = false;
			planTab0.mouseEnabled = false;
			addChild(planTab0);
			planTab0.x = 415 - planTab0.width;
			planTab0.y = - planTab0.height;
		}

		private function drawBackground() : void {
			background = new Shape();
			background.graphics.clear();
			background.graphics.beginFill(0x000000, 0.5);
			background.graphics.drawRoundRect(0, 0, 420, 50, 7);
			background.graphics.endFill();
			addChild(background);
		}
	}
}
