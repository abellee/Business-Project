package controller {
	import data.DressInterfaceData;

	import view.DressInterface;

	import com.kge.core.UIViewController;

	/**
	 * @author Abel
	 */
	public class DressInterfaceController extends UIViewController {
		private var clothesPanelController : FloatPanelController;
		private var trousersPanelController : FloatPanelController;
		private var suitPanelController : FloatPanelController;
		private var widgetsPanelController : FloatPanelController;

		public function DressInterfaceController() {
			super();
			view = new DressInterface();
			data = new DressInterfaceData();
		}
	}
}
