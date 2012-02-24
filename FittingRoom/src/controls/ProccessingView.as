package controls {
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;

	import resource.Resource;

	import flash.display.MovieClip;

	import com.kge.core.UIView;

	/**
	 * @author Abel
	 */
	public class ProccessingView extends UIView {
		private var background : Shape = new Shape();
		private var chrysanthemum : MovieClip = new (Resource.Chrysanthemum)();
		private var _parentContainer : DisplayObjectContainer;

		public function ProccessingView() {
			super();
		}

		public function show(parent : DisplayObjectContainer, mode : Boolean = true) : void {
			_parentContainer = parent;
			if (mode) {
				drawBackground(parent.width, parent.height);
			}
			addChild(chrysanthemum);
			chrysanthemum.play();
			chrysanthemum.x = (parent.width - chrysanthemum.width) / 2;
			chrysanthemum.y = (parent.height - chrysanthemum.height) / 2;
			parent.addChild(this);
		}

		public function hide() : void {
			if(_parentContainer && _parentContainer.contains(this)){
				_parentContainer.removeChild(this);
				chrysanthemum.stop();
			}
		}

		private function drawBackground(width : Number, height : Number) : void {
			background.graphics.clear();
			background.graphics.beginFill(0x000000, .3);
			background.graphics.drawRect(0, 0, width, height);
			background.graphics.endFill();
			addChildAt(background, 0);
		}
	}
}
