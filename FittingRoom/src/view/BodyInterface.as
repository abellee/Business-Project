package view {
	import com.greensock.TweenLite;
	import com.kge.core.UIView;
	
	import controls.BodyView;
	
	import data.DataParams;
	
	import delegates.FloatPanelDelegate;

	/**
	 * @author Abel
	 */
	public class BodyInterface extends UIView implements FloatPanelDelegate {
		private var bodyPanel : FloatPanel;
		private var hairPanel : FloatPanel;
		private var facePanel : FloatPanel;
		private var sizePanel : SizePanel;
		private var clothesPanelX0 : int;
		private var hairPanelX : int;
		private var hairPanelX0 : int;

		public function BodyInterface() {
			super();

			init();
		}

		private function init() : void {
			if (!bodyPanel) bodyPanel = new FloatPanel(3, "体型", DataParams.BODY, "right", false);
			bodyPanel.delegate = this;
			addChild(bodyPanel);
			bodyPanel.y = 30;

			if (!hairPanel) hairPanel = new FloatPanel(3, "发型", null, "left", false);
			hairPanel.delegate = this;
			addChildAt(hairPanel, 0);
			hairPanel.x = 762;
			hairPanel.y = bodyPanel.y;

			if (!facePanel) facePanel = new FloatPanel(3, "脸型", null, "left", false);
			facePanel.delegate = this;
			addChildAt(facePanel, 0);
			facePanel.x = hairPanel.x;
			facePanel.y = hairPanel.y + hairPanel.height + 10;

			if (!sizePanel) sizePanel = new SizePanel(0, "三围", null, "right", false);
			sizePanel.delegate = this;
			addChildAt(sizePanel, 0);
			sizePanel.x = bodyPanel.x;
			sizePanel.y = bodyPanel.y + bodyPanel.height + 10;

			clothesPanelX0 = -bodyPanel.width + 32;
			hairPanelX0 = hairPanelX + hairPanel.width - 30;
		}

		public function indentFloatPanel(panel : FloatPanel) : void {
			FittingRoom.instance.removeSearchPanel();
			FittingRoom.instance.closeDetailPanel();
			var targetPosX : int;
			if (panel == bodyPanel || panel == sizePanel) {
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

		public function changingFinished(displayObjectContainer : UIView) : void {
		}
	}
}
