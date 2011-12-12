package view {
	import delegates.FloatPanelDelegate;

	import com.greensock.TweenLite;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;

	/**
	 * @author Abel
	 */
	public class DressInterface extends UIView implements FloatPanelDelegate {
		private var clothesPanel : FloatPanel;
		private var trousersPanel : FloatPanel;
		private var hairPanel : FloatPanel;
		private var widgetPanel : FloatPanel;
		private var clothesPanelX : int;
		private var clothesPanelX0 : int;
		private var hairPanelX : int;
		private var hairPanelX0 : int;

		public function DressInterface() {
			super();
			if (!clothesPanel) clothesPanel = new FloatPanel(3, "上装");
			clothesPanel.delegate = this;
			addChild(clothesPanel);
			clothesPanel.y = 30;

			if (!trousersPanel) trousersPanel = new FloatPanel(3, "下装");
			trousersPanel.delegate = this;
			addChild(trousersPanel);
			trousersPanel.x = clothesPanel.x;
			trousersPanel.y = clothesPanel.y + clothesPanel.height + 10;

			if (!hairPanel) hairPanel = new FloatPanel(3, "套装", "left");
			hairPanel.delegate = this;
			addChild(hairPanel);
			hairPanel.x = 760;
			hairPanel.y = clothesPanel.y;

			if (!widgetPanel) widgetPanel = new FloatPanel(3, "鞋包", "left");
			widgetPanel.delegate = this;
			addChild(widgetPanel);
			widgetPanel.x = hairPanel.x;
			widgetPanel.y = hairPanel.y + hairPanel.height + 10;

			clothesPanelX0 = -clothesPanel.width + 52;
			hairPanelX0 = hairPanelX + hairPanel.width - 30;
		}

		public function changingFinished(view : UIView) : void {
		}

		public function indentFloatPanel(panel : FloatPanel) : void {
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
					targetPosX = 760;
					panel.isIndent = false;
				} else {
					panel.isIndent = true;
				}
			}
			TweenLite.to(panel, 0.3, {x:targetPosX});
		}
	}
}
