package view {
	import com.kge.containers.HGroup;
	import com.kge.containers.VGroup;
	import com.kge.core.UIView;
	
	import config.Config;
	
	import controls.Slider;
	
	import delegates.SliderDelegate;
	
	import factory.ButtonFactory;
	
	import fl.controls.Button;
	import fl.controls.CheckBox;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import global.Global;

	/**
	 * @author Abel
	 */
	public class SizePanel extends FloatPanel implements SliderDelegate {
		private var titleText : TextField;
		private var unitLabel : TextField;
		private var cmCB : CheckBox;
		private var inchCB : CheckBox;
		private var shoulderWidth : Slider;
		private var shoulderLabel : TextField;
		private var chestWidth : Slider;
		private var chestLabel : TextField;
		private var waistWidth : Slider;
		private var waistLabel : TextField;
		private var buttocksWidth : Slider;
		private var buttocksLabel : TextField;
		private var handWidth : Slider;
		private var handLabel : TextField;
		private var bodyHeight : Slider;
		private var bodyLabel : TextField;
		private var saveBody : Button;
		private var curState:String = "cm";
		private var labelGroup:VGroup = new VGroup();
		private var sliderGroup:VGroup = new VGroup();
		private var chooseColorLabel:TextField = new TextField();
		private var skinColorsGroup:HGroup;
		private var skinColorsContainer:Sprite;
		private var pageLeftButton:Button;
		private var pageRightButton:Button;
		private var restoreTextField:TextField = new TextField();

		public function SizePanel(columnNum : int, tabStr : String, p:String, dir : String = "right", search : Boolean = true) {
			super(columnNum, tabStr, null, dir, search);
		}

		override protected function init() : void {
			drawBackground();

			triangleButton = ButtonFactory.IndentationButton(_dir);
			if (_dir == "right") backButton = ButtonFactory.IndentationButton("left");
			else backButton = ButtonFactory.IndentationButton("right");
			addChild(triangleButton);
			addChild(backButton);
			backButton.visible = false;

			tabText = new TextField();
			tabText.defaultTextFormat = Global.fontStyle.whiteStyle;
			tabText.text = _tabStr;
			tabText.width = 20;
			tabText.height = 30;
			tabText.wordWrap = true;
			tabText.selectable = false;
			tabText.mouseEnabled = true;
			tabText.mouseWheelEnabled = false;
			addChild(tabText);
			if (_dir == "right") {
				tabText.x = 220 + (tab.width - tabText.width) / 2;
				triangleButton.x = tabText.x - triangleButton.width - 5;
				backButton.x = triangleButton.x;
			} else {
				tabText.x = -27 + (tab.width - tabText.width) / 2;
			}
			tabText.y = 10;
			triangleButton.y = tabText.y + 7;
			backButton.y = triangleButton.y;
			triangleButton.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			backButton.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			tabText.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			tabText.addEventListener(MouseEvent.MOUSE_OVER, onTab_mouseOverHandler);
			tabText.addEventListener(MouseEvent.MOUSE_OUT, onTab_mouseOutHandler);
			
			titleText = new TextField();
			titleText.autoSize = TextFieldAutoSize.LEFT;
			titleText.defaultTextFormat = Global.fontStyle.whiteStyle;
			titleText.text = "自定义体型";
			titleText.selectable = false;
			titleText.mouseEnabled = false;
			titleText.mouseWheelEnabled = false;
			titleText.x = 5;
			titleText.y = 10;
			addChild(titleText);
			
			unitLabel = new TextField();
			unitLabel.autoSize = TextFieldAutoSize.LEFT;
			unitLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			unitLabel.text = "单位:";
			unitLabel.selectable = false;
			unitLabel.mouseEnabled = false;
			unitLabel.mouseWheelEnabled = false;
			unitLabel.x = 5;
			unitLabel.y = titleText.height + titleText.y + 10;
			addChild(unitLabel);
			
			cmCB = ButtonFactory.CMCheckBox();
			cmCB.x = unitLabel.x + unitLabel.width + 5;
			cmCB.y = unitLabel.y - 3;
			addChild(cmCB);
			cmCB.selected = true;
			cmCB.addEventListener(Event.CHANGE, onCheckBoxChanged);
			
			inchCB = ButtonFactory.InchCheckBox();
			inchCB.x = cmCB.x + cmCB.width + 10;
			inchCB.y = unitLabel.y - 3;
			addChild(inchCB);
			inchCB.addEventListener(Event.CHANGE, onCheckBoxChanged);
			
			shoulderWidth = new Slider();
			shoulderWidth.sliderDelegate = this;
			shoulderWidth.sliderButton = ButtonFactory.SliderButton();
			shoulderWidth.maxValue = 100;
			shoulderWidth.minValue = 0;
			shoulderWidth.value = Config.instance.defaultSize[0];
			shoulderWidth.trackSkin = new Bitmap(Global.staticAssets.sliderTrack());
			shoulderWidth.progressSkin = new Bitmap(Global.staticAssets.sliderBar());
			
			shoulderLabel = new TextField();
			shoulderLabel.autoSize = TextFieldAutoSize.LEFT;
			shoulderLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			shoulderLabel.text = "肩宽";
			shoulderLabel.selectable = false;
			shoulderLabel.mouseEnabled = false;
			shoulderLabel.mouseWheelEnabled = false;
			
			chestWidth = new Slider();
			chestWidth.sliderDelegate = this;
			chestWidth.sliderButton = ButtonFactory.SliderButton();
			chestWidth.maxValue = 100;
			chestWidth.minValue = 0;
			chestWidth.value = Config.instance.defaultSize[1];
			chestWidth.trackSkin = new Bitmap(Global.staticAssets.sliderTrack());
			chestWidth.progressSkin = new Bitmap(Global.staticAssets.sliderBar());
			
			chestLabel = new TextField();
			chestLabel.autoSize = TextFieldAutoSize.LEFT;
			chestLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			chestLabel.text = "胸围";
			chestLabel.selectable = false;
			chestLabel.mouseEnabled = false;
			chestLabel.mouseWheelEnabled = false;
			
			waistWidth = new Slider();
			waistWidth.sliderDelegate = this;
			waistWidth.sliderButton = ButtonFactory.SliderButton();
			waistWidth.maxValue = 100;
			waistWidth.minValue = 0;
			waistWidth.value = Config.instance.defaultSize[2];
			waistWidth.trackSkin = new Bitmap(Global.staticAssets.sliderTrack());
			waistWidth.progressSkin = new Bitmap(Global.staticAssets.sliderBar());
			
			waistLabel = new TextField();
			waistLabel.autoSize = TextFieldAutoSize.LEFT;
			waistLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			waistLabel.text = "腰围";
			waistLabel.selectable = false;
			waistLabel.mouseEnabled = false;
			waistLabel.mouseWheelEnabled = false;
			
			buttocksWidth = new Slider();
			buttocksWidth.sliderDelegate = this;
			buttocksWidth.sliderButton = ButtonFactory.SliderButton();
			buttocksWidth.maxValue = 100;
			buttocksWidth.minValue = 0;
			buttocksWidth.value = Config.instance.defaultSize[3];
			buttocksWidth.trackSkin = new Bitmap(Global.staticAssets.sliderTrack());
			buttocksWidth.progressSkin = new Bitmap(Global.staticAssets.sliderBar());
			
			buttocksLabel = new TextField();
			buttocksLabel.autoSize = TextFieldAutoSize.LEFT;
			buttocksLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			buttocksLabel.text = "臀围";
			buttocksLabel.selectable = false;
			buttocksLabel.mouseEnabled = false;
			buttocksLabel.mouseWheelEnabled = false;
			
			handWidth = new Slider();
			handWidth.sliderDelegate = this;
			handWidth.sliderButton = ButtonFactory.SliderButton();
			handWidth.maxValue = 100;
			handWidth.minValue = 0;
			handWidth.value = Config.instance.defaultSize[4];
			handWidth.trackSkin = new Bitmap(Global.staticAssets.sliderTrack());
			handWidth.progressSkin = new Bitmap(Global.staticAssets.sliderBar());
			
			handLabel = new TextField();
			handLabel.autoSize = TextFieldAutoSize.LEFT;
			handLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			handLabel.text = "手长";
			handLabel.selectable = false;
			handLabel.mouseEnabled = false;
			handLabel.mouseWheelEnabled = false;
			
			bodyHeight = new Slider();
			bodyHeight.sliderDelegate = this;
			bodyHeight.sliderButton = ButtonFactory.SliderButton();
			bodyHeight.maxValue = 100;
			bodyHeight.minValue = 0;
			bodyHeight.value = Config.instance.defaultSize[5];
			bodyHeight.trackSkin = new Bitmap(Global.staticAssets.sliderTrack());
			bodyHeight.progressSkin = new Bitmap(Global.staticAssets.sliderBar());
			
			bodyLabel = new TextField();
			bodyLabel.autoSize = TextFieldAutoSize.LEFT;
			bodyLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			bodyLabel.text = "身高";
			bodyLabel.selectable = false;
			bodyLabel.mouseEnabled = false;
			bodyLabel.mouseWheelEnabled = false;
			
			labelGroup.addChild(shoulderLabel);
			labelGroup.addChild(chestLabel);
			labelGroup.addChild(waistLabel);
			labelGroup.addChild(buttocksLabel);
			labelGroup.addChild(handLabel);
			labelGroup.addChild(bodyLabel);
			addChild(labelGroup);
			labelGroup.gap = 5;
			
			labelGroup.x = unitLabel.x;
			labelGroup.y = unitLabel.y + unitLabel.textHeight + 10;
			
			sliderGroup.addChild(shoulderWidth);
			sliderGroup.addChild(chestWidth);
			sliderGroup.addChild(waistWidth);
			sliderGroup.addChild(buttocksWidth);;
			sliderGroup.addChild(handWidth);
			sliderGroup.addChild(bodyHeight)
			addChild(sliderGroup);
			sliderGroup.gap = 21;
			
			sliderGroup.x = labelGroup.x + shoulderLabel.textWidth + 15;
			sliderGroup.y = labelGroup.y + 5;
			
			chooseColorLabel = new TextField();
			chooseColorLabel.autoSize = TextFieldAutoSize.LEFT;
			chooseColorLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
			chooseColorLabel.text = "选择皮肤颜色";
			chooseColorLabel.selectable = false;
			chooseColorLabel.mouseEnabled = false;
			chooseColorLabel.mouseWheelEnabled = false;
			chooseColorLabel.x = 5;
			chooseColorLabel.y = 185;
			addChild(chooseColorLabel);
			
			skinColorsContainer = new Sprite();
			addChild(skinColorsContainer);
			skinColorsGroup = new HGroup();
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsGroup.addChild(getSprite());
			skinColorsContainer.addChild(skinColorsGroup);
			skinColorsContainer.scrollRect = new Rectangle(0, 0, 170, 20);
			skinColorsContainer.x = 23;
			skinColorsContainer.y = 205;
			
			pageLeftButton = ButtonFactory.PlanLeftArrow();
			pageRightButton = ButtonFactory.PlanRightArrow();
			addChild(pageLeftButton);
			addChild(pageRightButton);
			pageLeftButton.x = 5;
			pageLeftButton.y = 207;
			pageRightButton.x = 200;
			pageRightButton.y = 207;
			
			saveBody = ButtonFactory.GreenButton();
			saveBody.setStyle("textFormat", new TextFormat(null, 12, 0xFFFFFF));
			saveBody.label = "保存体型";
			addChild(saveBody);
			saveBody.x = 80;
			saveBody.y = 235;
			
			restoreTextField = new TextField();
			restoreTextField.addEventListener(TextEvent.LINK, restoreTextField_textEventHandler);
			var css:StyleSheet = new StyleSheet();
			css.setStyle("a:link", {color:'#92d118', textDecoration:'none'});
			css.setStyle("a:hover", {color:'#ffe000', textDecoration:'none'});
			restoreTextField.autoSize = TextFieldAutoSize.LEFT;
			restoreTextField.htmlText = "<a href='event:default'>恢复默认</a>";
			restoreTextField.selectable = false;
			restoreTextField.styleSheet = css;
			addChild(restoreTextField);
			restoreTextField.x = 160;
			restoreTextField.y = 239;
		}
		
		protected function restoreTextField_textEventHandler(event:TextEvent):void
		{
			
		}
		
		private function getSprite():Sprite{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xFFFFFF * Math.random());
			sp.graphics.drawRect(0, 0, 20, 20);
			sp.graphics.endFill();
			return sp;
		}
		
		override protected function drawBackground() : void {
			background.graphics.clear();
			background.graphics.beginFill(0x000000, .5);
			background.graphics.drawRect(0, 0, 220, 260);
			background.graphics.endFill();
			addChild(background);
			if (_dir == "right") {
				tab.graphics.clear();
				tab.graphics.beginFill(0x000000, .5);
				tab.graphics.drawRoundRectComplex(220, 0, 30, 50, 0, 8, 0, 8);
				tab.graphics.endFill();
				addChild(tab);
			} else {
				tab.graphics.clear();
				tab.graphics.beginFill(0x000000, .5);
				tab.graphics.drawRoundRectComplex(-30, 0, 30, 50, 8, 0, 8, 0);
				tab.graphics.endFill();
				addChild(tab);
			}
		}
		
		public function valueChanged(view : Slider, value : Number):void
		{
			switch(view){
				case shoulderWidth:
					FittingRoom.instance.bodyView.changeShoulder(value / 100);
					break;
				case chestWidth:
					
					break;
				case waistWidth:
					FittingRoom.instance.bodyView.changeWaist(value / 100);
					break;
				case buttocksWidth:
					FittingRoom.instance.bodyView.changeHip(value / 100);
					break;
				case handWidth:
					FittingRoom.instance.bodyView.changeHand(value / 100);
					break;
				case bodyHeight:
					FittingRoom.instance.bodyView.changeLeg(value / 100);
					break;
			}
		}
		
		private function onCheckBoxChanged(event : Event) : void {
			var checkBox:CheckBox = event.target as CheckBox;
			if(checkBox == cmCB){
				cmCB.selected = true;
				curState == "cm";
				inchCB.selected = false;
			}else{
				inchCB.selected = true;
				curState = "inch";
				cmCB.selected = false;
			}
		}
	}
}
