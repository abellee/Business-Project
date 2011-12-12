package view {
	import delegates.FloatPanelDelegate;
	import flash.geom.Matrix;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import global.Global;
	import flash.text.TextField;
	import factory.ButtonFactory;
	import fl.controls.Button;

	import flash.display.Shape;

	import com.kge.containers.TileGroup;
	import com.kge.core.UIView;

	/**
	 * @author Abel
	 */
	public class FloatPanel extends UIView {
		private var tileGroup : TileGroup;
		private var searchAndPages : SearchAndPages;
		private var triangleButton : Button;
		private var backButton:Button;
		private var _dir : String = "right";
		private var background : Shape = new Shape();
		private var tab : Shape = new Shape();
		private var tabText:TextField = new TextField();
		private var _isIndent:Boolean = false;

		public function FloatPanel(columnNum : int, tabStr:String, dir : String = "right") {
			super();
			tileGroup = new TileGroup();
			tileGroup.columnCount = columnNum;
			tileGroup.tileWidth = 62;
			tileGroup.tileHeight = 56;
			_dir = dir;

			drawBackground();

			searchAndPages = new SearchAndPages(_dir);
			addChild(searchAndPages);
			if (_dir == "right") {
				searchAndPages.x = background.x + background.width;
				searchAndPages.y = background.y + background.height - searchAndPages.height;
			} else {
				searchAndPages.x = background.x - 25;
				searchAndPages.y = background.y + background.height - searchAndPages.height;
			}
			
			triangleButton = ButtonFactory.IndentationButton(_dir);
			if(_dir == "right") backButton = ButtonFactory.IndentationButton("left");
			else backButton = ButtonFactory.IndentationButton("right");
			addChild(triangleButton);
			addChild(backButton);
			backButton.visible = false;
			
			tabText = new TextField();
			tabText.defaultTextFormat = Global.fontStyle.whiteStyle;
			tabText.text = tabStr;
			tabText.width = 20;
			tabText.height = 30;
			tabText.wordWrap = true;
			tabText.selectable = false;
			tabText.mouseEnabled = false;
			tabText.mouseWheelEnabled = false;
			addChild(tabText);
			if(_dir == "right"){
				tabText.x = 220 + (tab.width - tabText.width) / 2;
				triangleButton.x = tabText.x - triangleButton.width - 5;
				backButton.x = triangleButton.x;
			}else{
				tabText.x = -27 + (tab.width - tabText.width) / 2;
			}
			tabText.y = 10;
			triangleButton.y = tabText.y + 7;
			backButton.y = triangleButton.y;
			triangleButton.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			backButton.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
		}

		private function onTriangleButtonClicked(event : MouseEvent) : void {
			if(delegate && delegate is FloatPanelDelegate){
				(delegate as FloatPanelDelegate).indentFloatPanel(this);
			}
		}

		private function drawBackground() : void {
			background.graphics.clear();
			background.graphics.beginFill(0x000000, .5);
			background.graphics.drawRect(0, 0, 220, 230);
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

		public function showData() : void {
		}

		public function get isIndent() : Boolean {
			return _isIndent;
		}

		public function set isIndent(isIndent : Boolean) : void {
			if(_isIndent != isIndent){
				_isIndent = isIndent;
				if(_isIndent){
					backButton.visible = true;
					triangleButton.visible = false;
				}else{
					backButton.visible = false;
					triangleButton.visible = true;
				}
			}
		}
	}
}
