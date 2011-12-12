package view {
	import fl.controls.Button;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * @author Abel
	 */
	public class UIButton extends Sprite {
		private var button:Button;
		private var textField:TextField;
		public function UIButton(str:String, btn:Button, format:TextFormat) {
			super();
			
			this.mouseEnabled = false;
			
			button = btn;
			button.label = "";
			addChild(button);
			
			textField = new TextField();
			textField.defaultTextFormat = format;
			textField.wordWrap = true;
			textField.width = button.width - 10;
			textField.height = button.height - 10;
			textField.x = 4;
			textField.y = 5;
			textField.text = str;
			textField.selectable = false;
			textField.mouseEnabled = false;
			textField.mouseWheelEnabled = false;
			addChild(textField);
		}

	}
}
