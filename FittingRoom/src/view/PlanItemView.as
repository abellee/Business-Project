package view {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	import factory.ButtonFactory;

	import flash.display.Bitmap;

	import fl.controls.Button;

	import com.kge.core.UIView;

	/**
	 * @author Abel
	 */
	public class PlanItemView extends UIView {
		private var _deleteBtn : Button;
		private var _background : Bitmap;
		private var _planView : DisplayObject = null;

		public function PlanItemView() {
			super();

			init();
		}

		private function init() : void {
			_deleteBtn = ButtonFactory.DeleteButton();
			_background = ButtonFactory.Item();
			addChild(_background);
			addChild(_deleteBtn);
			_deleteBtn.visible = false;
			_deleteBtn.x = _background.width - _deleteBtn.width;
			_deleteBtn.y = _background.height - _deleteBtn.height;
		}

		public function addPlan(_view : DisplayObject) : void {
			if(_planView){
				removeChild(_planView);
				if(_planView is BitmapData) (_planView as BitmapData).dispose();
			}
			addChildAt(_view, 1);
			_planView = _view;
		}

		public function hasPlan() : Boolean {
			return Boolean(_planView);
		}
	}
}
