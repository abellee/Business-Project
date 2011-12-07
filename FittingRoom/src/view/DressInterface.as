package view {
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;

	/**
	 * @author Abel
	 */
	public class DressInterface extends UIView implements IUIView {
		public var clothesGroup : FloatPanel;
		public var trousersGroup : FloatPanel;
		public var suitGroup : FloatPanel;
		public var widgetsGroup : FloatPanel;

		public function DressInterface() {
			
		}

		public function showClothesGroup() : void {
			
		}

		public function showTrousersGroup() : void {
		}

		public function showSuitGroup() : void {
		}

		public function showWidgetsGroup() : void {
		}

		public function changingFinished(view : UIView) : void {
		}
		
		override public function dealloc():void
		{
			clothesGroup = null;
			trousersGroup = null;
			suitGroup = null;
			widgetsGroup = null;
		}
	}
}
