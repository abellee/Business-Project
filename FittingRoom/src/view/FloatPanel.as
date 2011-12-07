package view {
	import flash.display.Shape;
	import com.kge.containers.TileGroup;
	import com.kge.core.UIView;

	/**
	 * @author Abel
	 */
	public class FloatPanel extends UIView {
		private var tileGroup : TileGroup;
		private var searchAndPages : SearchAndPages;
		private var _dir:String = "right";
		
		private var background:Shape = new Shape();
		private var tab:Shape = new Shape();

		public function FloatPanel(columnNum:int, dir:String = "right") {
			super();
			tileGroup = new TileGroup();
			tileGroup.columnCount = 3;
			tileGroup.tileWidth = 62;
			tileGroup.tileHeight = 56;
			_dir = dir;
			
			drawBackground();
		}
		
		private function drawBackground():void
		{
			if(_dir == "right"){
				background.graphics.clear();
				background.graphics.beginFill(0x000000, .5);
				background.graphics.drawRect(0, 0, 220, 220);
				background.graphics.endFill();
				addChild(background);
				
				tab.graphics.clear();
				tab.graphics.beginFill(0x000000, .5);
				tab.graphics.drawRoundRectComplex(220, 0, 30, 50, 0, 8, 0, 8);
				tab.graphics.endFill();
				addChild(tab);
			}else{
				
			}
		}

		public function showData() : void {
			
		}
	}
}
