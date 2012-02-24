package controls
{
	import fl.controls.listClasses.CellRenderer;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	public class ListCellRenderer extends CellRenderer
	{
		public function ListCellRenderer()
		{
			super();
			
			this.setStyle("textFormat", new TextFormat(null, 12, 0xFFFFFF));
			this.setStyle("upSkin", getSprite(0x000000, 0));
			this.setStyle("overSkin", getSprite(0x000000, .3));
			this.setStyle("downSkin", getSprite(0x000000, .6));
			this.setStyle("selectedUpSkin", getSprite(0x000000, .3));
			this.setStyle("selectedOverSkin", getSprite(0x000000, .3));
			this.setStyle("selectedDownSkin", getSprite(0x000000, .3));
		}
		
		override public function set data(obj:Object):void
		{
			super.data = obj;
			if(obj.data == -1){
				this.setStyle("upSkin", getSprite(0xaaaaaa));
				this.setStyle("overSkin", getSprite(0xaaaaaa));
				this.setStyle("downSkin", getSprite(0xaaaaaa));
				this.setStyle("selectedUpSkin", getSprite(0xaaaaaa));
				this.setStyle("selectedOverSkin", getSprite(0xaaaaaa));
				this.setStyle("selectedDownSkin", getSprite(0xaaaaaa));
			}
		}
		
		private function getSprite(value:Number, alphaValue:Number = 1.0):Sprite{
			var sp:Sprite = new Sprite();
			sp.graphics.clear();
			sp.graphics.beginFill(value, alphaValue);
			sp.graphics.drawRect(0, 0, this.width, this.height);
			sp.graphics.endFill();
			return sp;
		}
	}
}