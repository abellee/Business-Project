package view {
	import flash.events.MouseEvent;

	import factory.ButtonFactory;

	import flash.display.Bitmap;

	import com.kge.containers.HGroup;

	import fl.controls.Button;

	import flash.display.Shape;

	import com.kge.core.UIView;

	/**
	 * @author Abel
	 */
	public class PlanView extends UIView {
		private var background : Shape;
		private var leftArrow : Button;
		private var rightArrow : Button;
		private var saveButton : Button;
		private var deleteButton : Button;
		private var planTab0 : Button;
		private var planTab1 : Button;
		private var planTab2 : Button;
		private var planTab3 : Button;
		private var tabGroup : HGroup;
		private var cellGroup : HGroup;
		private var cells : Vector.<UIView> = new Vector.<UIView>();
		private var curTab : Button;

		public function PlanView() {
			super();
			
			tabGroup = new HGroup();
			for (var j : int = 0; j < 4; j++) {
				this["planTab" + j] = ButtonFactory.PlanTabButton();
				(this["planTab" + j] as Button).label = "临时方案" + (j + 1);
				tabGroup.addChild(this["planTab" + j] as Button);
				addButtonListener((this["planTab" + j] as Button));
			}
			planTab0.selected = true;
			curTab = planTab0;
			addChild(tabGroup);
			tabGroup.x = 5;
			tabGroup.y = -planTab0.height;

			drawBackground();

			leftArrow = ButtonFactory.PlanLeftArrow();
			rightArrow = ButtonFactory.PlanRightArrow();
			addChild(leftArrow);
			addChild(rightArrow);
			leftArrow.x = 8;
			leftArrow.y = (50 - leftArrow.height) / 2;
			rightArrow.x = 365;
			rightArrow.y = leftArrow.y;

			saveButton = ButtonFactory.SaveButton();
			addChild(saveButton);
			saveButton.x = rightArrow.x + rightArrow.width + 15;
			saveButton.y = 3;

			deleteButton = ButtonFactory.DeleteButton();
			addChild(deleteButton);
			deleteButton.x = saveButton.x;
			deleteButton.y = saveButton.y + saveButton.height + 2;

			cellGroup = new HGroup();
			cellGroup.gap = 13;
			for (var i : int = 0; i < 6; i++) {
				var cell : UIView = new UIView();
				cell.addChild(ButtonFactory.Item());
				cells.push(cell);
				cellGroup.addChild(cell);
			}
			addChild(cellGroup);
			cellGroup.x = leftArrow.x + leftArrow.width + 11;
			cellGroup.y = (50 - cellGroup.height) / 2;
		}

		private function addButtonListener(btn : Button) : void {
			btn.addEventListener(MouseEvent.CLICK, onButtonClick);
		}

		private function onButtonClick(event : MouseEvent) : void {
			var btn : Button = event.currentTarget as Button;
			if (curTab) {
				if (curTab == btn) {
					curTab.selected = true;
					return;
				} else {
					curTab.selected = false;
				}
			}
			curTab = btn;
			if (btn == planTab0) {
			} else if (btn == planTab1) {
			} else if (btn == planTab2) {
			} else if (btn == planTab3) {
			}
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
