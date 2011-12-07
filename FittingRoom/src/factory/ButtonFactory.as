package factory {
	import fl.controls.Button;

	import global.Global;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Abel
	 */
	public class ButtonFactory {
		public static function DressInterfaceButton() : Button {
			var btn : Button = new Button();
			btn.emphasized = false;
			btn.toggle = true;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonUp());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonDown());
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("disabledSkin", upSkin);
			btn.setStyle("selectedUpSkin", downSkin);
			btn.setStyle("selectedOverSkin", downSkin);
			btn.setStyle("selectedDownSkin", downSkin);
			btn.setStyle("selectedDisabledSkin", downSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "体型模式";
			btn.setStyle("textFormat", Global.fontStyle.whiteStyle);
			btn.textField.autoSize = TextFieldAutoSize.CENTER;
			return btn;
		}

		public static function BodyInterfaceButton() : Button {
			var btn : Button = new Button();
			btn.emphasized = false;
			btn.toggle = true;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.middleButtonUp());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.middleButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.middleButtonDown());
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("disabledSkin", upSkin);
			btn.setStyle("selectedUpSkin", downSkin);
			btn.setStyle("selectedOverSkin", downSkin);
			btn.setStyle("selectedDownSkin", downSkin);
			btn.setStyle("selectedDisabledSkin", downSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "搭配模式";
			btn.setStyle("textFormat", Global.fontStyle.whiteStyle);
			btn.textField.autoSize = TextFieldAutoSize.CENTER;
			return btn;
		}

		public static function ScreenShotInterfaceButton() : Button {
			var btn : Button = new Button();
			btn.emphasized = false;
			btn.toggle = true;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonUp());
			var upBD : BitmapData = new BitmapData(upSkin.width, upSkin.height);
			var matrix : Matrix = new Matrix();
			matrix.translate(-upSkin.width, 0);
			matrix.scale(-1, 1);
			upBD.draw(upSkin, matrix, null, null, null, true);
			upSkin = new Bitmap(upBD);

			var overBD : BitmapData = new BitmapData(upSkin.width, upSkin.height);
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonOver());
			overBD.draw(overSkin, matrix, null, null, null, true);
			overSkin = new Bitmap(overBD);

			var downBD : BitmapData = new BitmapData(upSkin.width, upSkin.height);
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonDown());
			downBD.draw(downSkin, matrix, null, null, null, true);
			downSkin = new Bitmap(downBD);
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("disabledSkin", upSkin);
			btn.setStyle("selectedUpSkin", downSkin);
			btn.setStyle("selectedOverSkin", downSkin);
			btn.setStyle("selectedDownSkin", downSkin);
			btn.setStyle("selectedDisabledSkin", downSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "拍照模式";
			btn.setStyle("textFormat", Global.fontStyle.whiteStyle);
			btn.textField.autoSize = TextFieldAutoSize.CENTER;
			return btn;
		}

		public static function PageButton() : Button {
			var btn : Button = new Button();
			return btn;
		}

		public static function SearchButton() : Button {
			var btn : Button = new Button();
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.greenButtonUp());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.greenButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.greenButtonDown());
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("disabledSkin", upSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "搜索";
			btn.setStyle("textFormat", Global.fontStyle.whiteStyle);
			btn.textField.autoSize = TextFieldAutoSize.CENTER;
			return btn;
		}

		public static function FlipButton() : Button {
			var btn : Button = new Button();
			return btn;
		}
	}
}
