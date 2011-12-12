package delegates {
	import com.kge.delegates.IUIView;
	import view.FloatPanel;

	/**
	 * @author Abel
	 */
	public interface FloatPanelDelegate extends IUIView {
		function indentFloatPanel(panel : FloatPanel) : void;
	}
}
