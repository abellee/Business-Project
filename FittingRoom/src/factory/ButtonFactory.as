package factory {
	import controls.Slider;
	
	import fl.controls.Button;
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.CheckBox;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import global.Global;
	
	import utils.Tool;
	
	import view.UIButton;

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
			var upBD : BitmapData = new BitmapData(upSkin.width, upSkin.height, true, 0x00);
			var matrix : Matrix = new Matrix();
			matrix.translate(-upSkin.width, 0);
			matrix.scale(-1, 1);
			upBD.draw(upSkin, matrix, null, null, null, true);
			upSkin = new Bitmap(upBD);

			var overBD : BitmapData = new BitmapData(upSkin.width, upSkin.height, true, 0x00);
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.topLeftButtonOver());
			overBD.draw(overSkin, matrix, null, null, null, true);
			overSkin = new Bitmap(overBD);

			var downBD : BitmapData = new BitmapData(upSkin.width, upSkin.height, true, 0x00);
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

		public static function SearchButton(dir : String) : UIButton {
			var btn : Button = new Button();
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.searchUp());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.searchOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.searchDown());

			if (dir == "left") {
				var matrix : Matrix = new Matrix();
				matrix.translate(- upSkin.width, 0);
				matrix.scale(-1, 1);

				var tempUp : BitmapData = new BitmapData(upSkin.width, upSkin.height, true, 0x00);
				tempUp.draw(upSkin, matrix, null, null, null, true);
				upSkin = new Bitmap(tempUp);

				var tempOver : BitmapData = new BitmapData(overSkin.width, overSkin.height, true, 0x00);
				tempOver.draw(overSkin, matrix, null, null, null, true);
				overSkin = new Bitmap(tempOver);

				var tempDown : BitmapData = new BitmapData(downSkin.width, downSkin.height, true, 0x00);
				tempDown.draw(downSkin, matrix, null, null, null, true);
				downSkin = new Bitmap(tempDown);
			}

			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("disabledSkin", upSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.textField.autoSize = TextFieldAutoSize.CENTER;

			var uiButton : UIButton = new UIButton("搜索", btn, Global.fontStyle.whiteStyle);
			return uiButton;
		}

		public static function IndentationButton(dir : String) : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.inArrowUp());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.inArrowDown());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.inArrowOver());

			if (dir == "left") {
				var matrix : Matrix = new Matrix();
				matrix.translate(- upSkin.width, 0);
				matrix.scale(-1, 1);

				var tempUp : BitmapData = new BitmapData(upSkin.width, upSkin.height, true, 0x00);
				tempUp.draw(upSkin, matrix, null, null, null, true);
				upSkin = new Bitmap(tempUp);

				var tempOver : BitmapData = new BitmapData(overSkin.width, overSkin.height, true, 0x00);
				tempOver.draw(overSkin, matrix, null, null, null, true);
				overSkin = new Bitmap(tempOver);

				var tempDown : BitmapData = new BitmapData(downSkin.width, downSkin.height, true, 0x00);
				tempDown.draw(downSkin, matrix, null, null, null, true);
				downSkin = new Bitmap(tempDown);
			}

			btn.setStyle("upSkin", upSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("overSkin", overSkin);
			btn.label = "";
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			return btn;
		}

		public static function PageButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.pageButtonDown());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.pageButtonOver());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.pageButtonUp());
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			return btn;
		}

		public static function FlipUpButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.upArrowOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.upArrowDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.upArrowUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function FlipDownButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.downArrowOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.downArrowDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.downArrowUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function BackgroundFlipButtonLeft() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.backgroundFlipButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.backgroundFlipButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.backgroundFlipButtonUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function BackgroundFlipButtonRight() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Tool.bitmapDataReverseX(Global.staticAssets.backgroundFlipButtonOver()));
			var downSkin : Bitmap = new Bitmap(Tool.bitmapDataReverseX(Global.staticAssets.backgroundFlipButtonDown()));
			var upSkin : Bitmap = new Bitmap(Tool.bitmapDataReverseX(Global.staticAssets.backgroundFlipButtonUp()));
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function Item() : Bitmap {
			return new Bitmap(Global.staticAssets.rectFrame());
		}

		public static function PlanLeftArrow() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.arrowOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.arrowDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.arrowUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function PlanRightArrow() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Tool.bitmapDataReverseX(Global.staticAssets.arrowOver()));
			var downSkin : Bitmap = new Bitmap(Tool.bitmapDataReverseX(Global.staticAssets.arrowDown()));
			var upSkin : Bitmap = new Bitmap(Tool.bitmapDataReverseX(Global.staticAssets.arrowUp()));
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function DeleteButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.deleteButtonUp());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.deleteButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.deleteButtonOver());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function SaveButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.saveButtonUp());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.saveButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.saveButtonOver());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function PlanTabButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.setStyle("textFormat", new TextFormat("宋体", 12, 0xFFFFFF));
			btn.emphasized = false;
			btn.toggle = true;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.tempPlanTabOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.tempPlanTabDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.tempPlanTabUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("selectedUpSkin", downSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("selectedDownSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("selectedOverSkin", downSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			return btn;
		}

		public static function HelpButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.helpButtonDown());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.helpButtonOver());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.helpButtonUp());
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function TurnArroundButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.turnArroundButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.turnArroundButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.turnArroundButtonUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function ResumeButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.resumeButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.resumeButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.resumeButtonUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function ZoomOutButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.zoomOutOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.zoomOutDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.zoomOutUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function ZoomInButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.zoomInOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.zoomInDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.zoomInUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function ZoomClothesButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.clothesButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.clothesButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.clothesButtonUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function ZoomTrousersButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.trousersOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.trousersDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.trousersUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function ZoomShoeButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.shoeButtonOver());
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.shoeButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.shoeButtonUp());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}

		public static function CMCheckBox() : CheckBox {
			var checkBox : CheckBox = new CheckBox();
			checkBox.textField.autoSize = TextFieldAutoSize.LEFT;
			checkBox.mouseChildren = false;
			checkBox.mouseEnabled = true;
			var upIcon : Bitmap = new Bitmap(Global.staticAssets.cmUp());
			var downIcon : Bitmap = new Bitmap(Global.staticAssets.cmSelected());
			checkBox.setStyle("selectedOverIcon", downIcon);
			checkBox.setStyle("upIcon", upIcon);
			checkBox.setStyle("selectedUpIcon", downIcon);
			checkBox.setStyle("downIcon", downIcon);
			checkBox.setStyle("overIcon", upIcon);
			checkBox.setStyle("selectedDownIcon", downIcon);
			checkBox.setStyle("focusRectSkin", new Sprite());
			checkBox.width = upIcon.width;
			checkBox.height = upIcon.height;
			checkBox.label = "";
			return checkBox;
		}

		public static function InchCheckBox() : CheckBox {
			var checkBox : CheckBox = new CheckBox();
			checkBox.textField.autoSize = TextFieldAutoSize.LEFT;
			checkBox.mouseChildren = false;
			checkBox.mouseEnabled = true;
			var upIcon : Bitmap = new Bitmap(Global.staticAssets.inchUp());
			var downIcon : Bitmap = new Bitmap(Global.staticAssets.inchSelected());
			checkBox.setStyle("selectedOverIcon", downIcon);
			checkBox.setStyle("upIcon", upIcon);
			checkBox.setStyle("selectedUpIcon", downIcon);
			checkBox.setStyle("downIcon", downIcon);
			checkBox.setStyle("overIcon", upIcon);
			checkBox.setStyle("selectedDownIcon", downIcon);
			checkBox.setStyle("focusRectSkin", new Sprite());
			checkBox.width = upIcon.width;
			checkBox.height = upIcon.height;
			checkBox.label = "";
			return checkBox;
		}

		public static function SliderButton() : Button {
			var btn : Button = new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var downSkin : Bitmap = new Bitmap(Global.staticAssets.sliderButtonDown());
			var upSkin : Bitmap = new Bitmap(Global.staticAssets.sliderButtonUp());
			var overSkin : Bitmap = new Bitmap(Global.staticAssets.sliderButtonOver());
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}
		
		public static function SearchConditionButton(dir:String):Button{
			var btn:Button= new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var downSkin:Bitmap = new Bitmap(Global.staticAssets.searchButtonDown());
			var overSkin:Bitmap = new Bitmap(Global.staticAssets.searchButtonOver());
			var upSkin:Bitmap = new Bitmap(Global.staticAssets.searchButtonUp());
			if(dir == "left"){
				downSkin = new Bitmap(Tool.bitmapDataReverseX(downSkin.bitmapData));
				overSkin = new Bitmap(Tool.bitmapDataReverseX(overSkin.bitmapData));
				upSkin = new Bitmap(Tool.bitmapDataReverseX(upSkin.bitmapData));
			}
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}
		
		public static function SearchPanelCloseButton():Button{
			var btn:Button= new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var downSkin:Bitmap = new Bitmap(Global.staticAssets.closeButtonOver());
			var upSkin:Bitmap = new Bitmap(Global.staticAssets.closeButtonUp());
			var overSkin:Bitmap = new Bitmap(Global.staticAssets.closeButtonDown());
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}
		
		public static function GreenButton():Button{
			var btn:Button= new Button();
			btn.textField.autoSize = TextFieldAutoSize.LEFT;
			btn.emphasized = false;
			btn.toggle = false;
			btn.mouseChildren = false;
			btn.mouseEnabled = true;
			var overSkin:Bitmap = new Bitmap(Global.staticAssets.greenButtonOver());
			var upSkin:Bitmap = new Bitmap(Global.staticAssets.greenButtonUp());
			var downSkin:Bitmap = new Bitmap(Global.staticAssets.greenButtonDown());
			btn.setStyle("overSkin", overSkin);
			btn.setStyle("downSkin", downSkin);
			btn.setStyle("upSkin", upSkin);
			btn.setStyle("focusRectSkin", new Sprite());
			btn.width = upSkin.width;
			btn.height = upSkin.height;
			btn.label = "";
			return btn;
		}
	}
}
