package controls
{
	import com.kge.core.UIView;
	
	import data.Direction;
	import data.Dress;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import resource.Resource;
	
	public class BodyView extends UIView
	{
		private var _sex:int = 0;
		
		private var arm0_0 : Bitmap = new (Resource.ArmBack)();
		private var arm1_0 : Bitmap = new (Resource.ArmFront)();
		private var chest0_0 : Bitmap = new (Resource.ChestBack)();
		private var chest1_0 : Bitmap = new (Resource.ChestFront)();
		private var waist0_0 : Bitmap = new (Resource.WaistBack)();
		private var waist1_0 : Bitmap = new (Resource.WaistFront)();
		private var leg0_0 : Bitmap = new (Resource.LegBack)();
		private var leg1_0 : Bitmap = new (Resource.LegFront)();
		private var face0_0 : Bitmap = new (Resource.FaceBack)();
		private var face1_0 : Bitmap = new (Resource.FaceFront)();
		
		private var waistMask : Shape = new Shape();
		
		/**
		 * 皮肤层
		 */
		private var _skinLayer:Sprite = new Sprite();
		/**
		 * 头部层
		 */
		private var _headLayer:Sprite = new Sprite();
		/**
		 * 手臂层
		 */
		private var _handLayer:Sprite = new Sprite();
		/**
		 * 身体层
		 */
		private var _bodyLayer:Sprite = new Sprite();
		/**
		 * 腰层
		 */
		private var _waistLayer:Sprite = new Sprite();
		/**
		 * 腿层
		 */
		private var _legLayer:Sprite = new Sprite();
		
		
		/**
		 * 帽子层
		 */
		private var _hatLayer:Sprite = new Sprite();
		/**
		 * 头发层
		 */
		private var _hairLayer:Sprite = new Sprite();
		/**
		 * 衣服层
		 */
		private var _clothesLayer:Sprite = new Sprite();
		/**
		 * 围巾层
		 */
		private var _scarfLayer:Sprite = new Sprite();
		/**
		 * 项链层
		 */
		private var _necklaceLayer:Sprite = new Sprite();
		/**
		 * 手提包层
		 */
		private var _bagLayer:Sprite = new Sprite();
		/**
		 * 腰带层
		 */
		private var _waistbandLayer:Sprite = new Sprite();
		/**
		 * 眼镜层
		 */
		private var _glassLayer:Sprite = new Sprite();
		/**
		 * 裤子层
		 */
		private var _trousersLayer:Sprite = new Sprite();
		/**
		 * 鞋子层
		 */
		private var _shoeLayer:Sprite = new Sprite();
		
		private var _dir:String = Direction.FRONT;
		
		private var curWaist:Number = 0;
		public function BodyView()
		{
			super();
			
			init();
		}
		
		private function init():void{
			addChild(_hatLayer);
			
			addChild(_skinLayer);
			
			_skinLayer.addChild(_handLayer);
			_skinLayer.addChild(_bodyLayer);
			_skinLayer.addChild(_waistLayer);
			_skinLayer.addChild(_legLayer);
			_skinLayer.addChild(_headLayer);
			
			_headLayer.addChild(face1_0);
			face1_0.x = -face1_0.width / 2;
			_handLayer.addChild(arm1_0);
			arm1_0.x = -arm1_0.width / 2;
			_bodyLayer.addChild(chest1_0);
			chest1_0.x = -chest1_0.width / 2;
			_waistLayer.addChild(waist1_0);
			waist1_0.x = -waist1_0.width / 2;
			_legLayer.addChild(leg1_0);
			leg1_0.x = -leg1_0.width / 2;
			
			_headLayer.x = _headLayer.width / 2 + 157;
			_headLayer.y = -55;
			_handLayer.x = _handLayer.width / 2 + 50;
			_handLayer.y = 100;
			_bodyLayer.x = 132 + _bodyLayer.width / 2;
			_bodyLayer.y = 67;
			_bodyLayer.width += 3;
			_waistLayer.x = 123 + _waistLayer.width / 2;
			_waistLayer.y = 216;
			_legLayer.x = 111 + _legLayer.width / 2;
			_legLayer.y = 305;
			
			addChild(_glassLayer);
			addChild(_hairLayer);
			addChild(_clothesLayer);
			addChild(_necklaceLayer);
			addChild(_scarfLayer);
			addChild(_shoeLayer);
			addChild(_trousersLayer);
			addChild(_waistbandLayer);
			addChild(_bagLayer);
			
			drawShape();
			addChild(waistMask);
			_waistLayer.mask = waistMask;
		}
		
		public function turnAround(front:Boolean = true):void
		{
			if(front){
				_dir = Direction.FRONT;
				init();
			}else{
				_dir = Direction.BACK;
				//back
			}
		}
		
		private function drawShape(value:Number = 0) : void {
			waistMask.graphics.clear();
			waistMask.graphics.beginFill(0x00FF00, 0.5);
			waistMask.graphics.moveTo(_waistLayer.x - _waistLayer.width / 2 + 25, _waistLayer.y);
			waistMask.graphics.lineTo(_waistLayer.width / 2 + _waistLayer.x - 25, _waistLayer.y);
			waistMask.graphics.curveTo(_waistLayer.width / 2 + _waistLayer.x - value, _waistLayer.y + _waistLayer.height / 2, _legLayer.x + _legLayer.width / 2 - 10, _legLayer.y + 5);
			waistMask.graphics.curveTo(_waistLayer.x, _waistLayer.y + _waistLayer.height + 25, _legLayer.x - _legLayer.width / 2 + 10, _legLayer.y + 5);
			waistMask.graphics.curveTo(_waistLayer.x - _waistLayer.width / 2 + value, _waistLayer.y + _waistLayer.height / 2, _waistLayer.x - _waistLayer.width / 2 + 25, _waistLayer.y);
			waistMask.graphics.endFill();
		}
		
		public function changeSkinColor():void
		{
			
		}
		
		public function changeHand(value : Number):void
		{
			_handLayer.scaleY = value;
		}
		
		public function changeShoulder(value : Number):void
		{
			_handLayer.scaleX = value;
		}
		
		public function changeWaist(value : Number):void
		{
			curWaist = 1 - value;
			drawShape(curWaist * _waistLayer.width);
			_waistLayer.mask = waistMask;
		}
		
		public function changeLeg(value : Number):void
		{
			_legLayer.scaleY = value;
		}
		
		public function changeHip(value : Number):void
		{
			_legLayer.scaleX = value;
			drawShape(curWaist * _waistLayer.width);
			_waistLayer.mask = waistMask;
		}
		
		public function replaceFace(dress:Dress):void
		{
			if(!dress){
				if(_headLayer.numChildren){
					_headLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _headLayer.addChild(bp);
			}
		}
		
		public function replaceHair(dress:Dress):void
		{
			if(!dress){
				if(_hairLayer.numChildren){
					_hairLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _hairLayer.addChild(bp);
			}
		}
		
		public function replaceHat(dress:Dress):void
		{
			if(!dress){
				if(_hatLayer.numChildren){
					_hatLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _hatLayer.addChild(bp);
			}
		}
		
		public function replaceGlass(dress:Dress):void
		{
			if(!dress){
				if(_glassLayer.numChildren){
					_glassLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _glassLayer.addChild(bp);
			}
		}
		
		public function replaceClothes(dress:Dress):void
		{
			if(!dress){
				if(_clothesLayer.numChildren){
					_clothesLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _clothesLayer.addChild(bp);
			}
		}
		
		public function replaceNecklace(dress:Dress):void
		{
			if(!dress){
				if(_necklaceLayer.numChildren){
					_necklaceLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _necklaceLayer.addChild(bp);
			}
		}
		
		public function replaceScarf(dress:Dress):void
		{
			if(!dress){
				if(_scarfLayer.numChildren){
					_scarfLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _scarfLayer.addChild(bp);
			}
		}
		
		public function replaceWaistband(dress:Dress):void
		{
			if(!dress){
				if(_waistbandLayer.numChildren){
					_waistbandLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _waistbandLayer.addChild(bp);
			}
		}
		
		public function replaceTrousers(dress:Dress):void
		{
			if(!dress){
				if(_trousersLayer.numChildren){
					_trousersLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _trousersLayer.addChild(bp);
			}
		}
		
		public function replaceShoes(dress:Dress):void
		{
			if(!dress){
				if(_shoeLayer.numChildren){
					_shoeLayer.removeChildAt(0);
				}
			}else{
				var bp:Bitmap = dress.getBitmapByDir(_dir);
				if(bp) _shoeLayer.addChild(bp);
			}
		}

		public function get sex():int
		{
			return _sex;
		}

		public function set sex(value:int):void
		{
			_sex = value;
		}

	}
}