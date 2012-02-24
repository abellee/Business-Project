package view {
	import com.greensock.TweenLite;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;
	
	import data.DataParams;
	
	import delegates.FloatPanelDelegate;

	/**
	 * @author Abel
	 */
	public class DressInterface extends UIView implements FloatPanelDelegate {
		private var clothesPanel : FloatPanel;
		private var trousersPanel : FloatPanel;
		private var hairPanel : FloatPanel;
		private var widgetPanel : FloatPanel;
		private var clothesPanelX0 : int;
		private var hairPanelX : int;
		private var hairPanelX0 : int;

		public function DressInterface() {
			super();
			if (!clothesPanel) clothesPanel = new FloatPanel(3, "上装", DataParams.CLOTHES);
			clothesPanel.delegate = this;
			addChild(clothesPanel);
			clothesPanel.y = 30;

			if (!trousersPanel) trousersPanel = new FloatPanel(3, "下装", DataParams.TROUSERS);
			trousersPanel.delegate = this;
			addChildAt(trousersPanel, 0);
			trousersPanel.x = clothesPanel.x;
			trousersPanel.y = clothesPanel.y + clothesPanel.height + 10;

			if (!hairPanel) hairPanel = new FloatPanel(3, "套装", null, "left");
			hairPanel.delegate = this;
			addChildAt(hairPanel, 0);
			hairPanel.x = 762;
			hairPanel.y = clothesPanel.y;

			if (!widgetPanel) widgetPanel = new FloatPanel(3, "鞋包", null, "left");
			widgetPanel.delegate = this;
			addChildAt(widgetPanel, 0);
			widgetPanel.x = hairPanel.x;
			widgetPanel.y = hairPanel.y + hairPanel.height + 10;

			clothesPanelX0 = -clothesPanel.width + 55;
			hairPanelX0 = hairPanelX + hairPanel.width - 30;
		}

		public function changingFinished(view : UIView) : void {
		}

		public function indentFloatPanel(panel : FloatPanel) : void {
			FittingRoom.instance.removeSearchPanel();
			FittingRoom.instance.closeDetailPanel();
			var targetPosX : int;
			if (panel == clothesPanel || panel == trousersPanel) {
				targetPosX = clothesPanelX0;
				if (panel.isIndent) {
					targetPosX = 0;
					panel.isIndent = false;
				} else {
					panel.isIndent = true;
				}
			} else {
				targetPosX = 980;
				if (panel.isIndent) {
					targetPosX = 762;
					panel.isIndent = false;
				} else {
					panel.isIndent = true;
				}
			}
			TweenLite.to(panel, 0.3, {x:targetPosX});
		}
	}
}
