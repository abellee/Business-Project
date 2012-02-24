package controls
{
	import com.kge.containers.VGroup;
	import com.kge.core.UIView;
	
	import factory.ButtonFactory;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import global.Global;
	
	import utils.ScaleBitmap;
	import utils.Tool;
	
	public class DetailPanel extends UIView
	{
		private var background:Shape = new Shape();
		private var realBackground:Shape = new Shape();
		private var productIdField:TextField = new TextField();
		private var productNameField:TextField = new TextField();
		private var priceLabel:Sprite = new Sprite();
		private var priceField:TextField = new TextField();
		private var priceBackground:ScaleBitmap;
		private var collectionButton:Button;
		private var moreDetail:TextField = new TextField();
		private var colorGroup:VGroup = new VGroup();
		private var closeButton:Button;
		private var bitmap:Bitmap;
		public function DetailPanel()
		{
			super();
			
			drawBackground();
			
			productIdField.defaultTextFormat = new TextFormat(null, 12, 0x000000);
			productIdField.autoSize = TextFieldAutoSize.LEFT;
			
			productNameField.defaultTextFormat = new TextFormat(null, 12, 0x000000);
			productNameField.autoSize = TextFieldAutoSize.LEFT;
			
			priceBackground = new ScaleBitmap(Global.staticAssets.greenButtonUp());
			priceBackground.scale9Grid = new Rectangle(12, 6, 31, 7);
			priceField.defaultTextFormat = new TextFormat(null, 12, 0xFFFFFF);
			priceField.autoSize = TextFieldAutoSize.LEFT;
			priceLabel.mouseEnabled = false;
			priceLabel.mouseChildren = false;
			priceLabel.addChild(priceBackground);
			priceLabel.addChild(priceField);
			
			collectionButton = ButtonFactory.GreenButton();
			collectionButton.label = "收藏";
			collectionButton.addEventListener(MouseEvent.CLICK, collectionButton_mouseClickHandler);
			
			moreDetail.defaultTextFormat = new TextFormat(null, 12, 0x000000);
			moreDetail.autoSize = TextFieldAutoSize.LEFT;
			moreDetail.text = "更多详情";
			moreDetail.addEventListener(MouseEvent.CLICK, moreDetail_mouseClickHandler);
			
			closeButton = ButtonFactory.SearchPanelCloseButton();
			addChild(closeButton);
			closeButton.x = background.width - closeButton.width - 5;
			closeButton.y = 5;
			closeButton.addEventListener(MouseEvent.CLICK, closeButton_mouseClickHandler);
		}
		
		protected function moreDetail_mouseClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function collectionButton_mouseClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function closeButton_mouseClickHandler(event:MouseEvent):void
		{
			FittingRoom.instance.closeDetailPanel();
		}
		
		public function addProductImage(bp:Bitmap):void
		{
			bitmap = bp;
			addChild(bp);
			bp.x = (background.width - bp.width) / 2;
			bp.y = 10;
		}
		
		public function productIdAndName(id:String, name:String):void
		{
			productIdField.text = "货号: " + id;
			addChild(productIdField);
			productIdField.x = (background.width - productIdField.textWidth) / 2;
			if(bitmap){
				productIdField.y = bitmap.y + bitmap.height + 10;
			}
			addChild(productNameField);
			productNameField.text = name;
			productNameField.x = (background.width - productNameField.textWidth) / 2;
			productNameField.y = productIdField.y + productIdField.textHeight + 5;
		}
		
		public function setPrice(value:Number):void
		{
			priceField.text = "吊牌价 ¥" + value;
			priceBackground.width = background.width - 20;
			priceBackground.height = priceField.textHeight + 10;
			priceField.x = (priceBackground.width - priceField.textWidth) / 2;
			priceField.y = 5;
			priceLabel.x = (background.width - priceBackground.width) / 2;
			priceLabel.y = productNameField.y + productNameField.textHeight + 10;
			addChild(priceLabel);
			addChild(collectionButton);
			addChild(moreDetail);
			collectionButton.y = priceLabel.y + priceBackground.height + 10;
			collectionButton.x = priceLabel.x;
			moreDetail.x = collectionButton.x + collectionButton.width + 10;
			moreDetail.y = collectionButton.y + (collectionButton.height - moreDetail.textHeight) / 2;
		}
		
		public function setColors(list:Vector.<Number>):void
		{
			colorGroup.removeAllChildren();
			for each(var num:Number in list){
				colorGroup.addChild(getRectByColor(num));
			}
			addChild(colorGroup);
			colorGroup.gap = 10;
			colorGroup.x = background.width - 25;
			colorGroup.y = bitmap.y + 20;
		}
		
		private function getRectByColor(value:Number):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(value, 1.0);
			sp.graphics.drawRect(0, 0, 20, 20);
			sp.graphics.endFill();
			return sp;
		}
		
		private function drawBackground():void
		{
			background.graphics.clear();
			background.graphics.beginFill(0xcecece, 1);
			background.graphics.drawRoundRect(0, 0, 185, 300, 10, 10);
			background.graphics.endFill();
			background.filters = [Tool.getBitmapFilter()];
			addChild(background);
			
			realBackground.graphics.clear();
			realBackground.graphics.beginFill(0xcecece, .5);
			realBackground.graphics.drawRoundRect(0, 0, 185, 300, 10, 10);
			realBackground.graphics.endFill();
			addChild(realBackground);
		}
	}
}