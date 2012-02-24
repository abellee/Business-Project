package controls {
	import com.kge.core.UIView;
	
	import delegates.SliderDelegate;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import global.Global;

	/**
	 * @author Abel
	 */
	public class Slider extends UIView {
		private var _trackSkin : Bitmap;
		private var _progressSkin : Bitmap;
		private var _sliderButton : Button;
		private var _value : Number = 0;
		private var _maxValue : Number;
		private var _minValue : Number;
		private var _originWidth : Number;
		private var _valueLabel:TextField;
		public var sliderDelegate : SliderDelegate;

		public function Slider() {
			super();
		}

		override protected function doChange() : void {
			super.doChange();
			draw();
		}

		private function draw() : void {
			if(!_valueLabel){
				_valueLabel = new TextField();
				_valueLabel.autoSize = TextFieldAutoSize.LEFT;
				_valueLabel.defaultTextFormat = Global.fontStyle.whiteStyle;
				_valueLabel.text = "0";
				_valueLabel.selectable = false;
				_valueLabel.mouseEnabled = false;
				_valueLabel.mouseWheelEnabled = false;
			}
			_valueLabel.text = _value + "";
			addChild(_valueLabel);
			_valueLabel.x = _trackSkin.x + _trackSkin.width + 10;
			_valueLabel.y = -(_valueLabel.textHeight - _trackSkin.height) / 2;
			
			addChildAt(_trackSkin, 0);
			addChild(_progressSkin);
			addChild(_sliderButton);
			_sliderButton.addEventListener(MouseEvent.MOUSE_DOWN, dragSliderButton);
			stage.addEventListener(MouseEvent.MOUSE_UP, dropSliderButton);

			_progressSkin.y = (_trackSkin.height - _progressSkin.height) / 2;
			_progressSkin.width = _originWidth * (_value / _maxValue);
			_sliderButton.x = _progressSkin.width - _sliderButton.width / 2;
			_sliderButton.y = -(_sliderButton.height - _trackSkin.height) / 2;
		}

		private function dropSliderButton(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		private function dragSliderButton(event : MouseEvent) : void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		private function onMouseMove(event : MouseEvent) : void {
			_sliderButton.x = this.mouseX - _sliderButton.width / 2;
			if(_sliderButton.x > (_trackSkin.width - _sliderButton.width / 2)){
				_sliderButton.x = _trackSkin.width - _sliderButton.width / 2;
			}else if(_sliderButton.x < -_sliderButton.width / 2){
				_sliderButton.x = -_sliderButton.width / 2;
			}
			_value = Number(((_sliderButton.x + _sliderButton.width / 2) / _originWidth * _maxValue).toFixed(2));
			_progressSkin.width = _sliderButton.x + _sliderButton.width / 2;
			_valueLabel.text = _value + "";
			if(sliderDelegate) sliderDelegate.valueChanged(this, _value);
		}

		public function get trackSkin() : Bitmap {
			return _trackSkin;
		}

		public function set trackSkin(trackSkin : Bitmap) : void {
			if (_trackSkin != trackSkin) {
				_trackSkin = trackSkin;
				_originWidth = _trackSkin.width;
				hasChanged();
			}
		}

		public function get progressSkin() : Bitmap {
			return _progressSkin;
		}

		public function set progressSkin(progressSkin : Bitmap) : void {
			if (_progressSkin != progressSkin) {
				_progressSkin = progressSkin;
				hasChanged();
			}
		}

		public function get sliderButton() : Button {
			return _sliderButton;
		}

		public function set sliderButton(sliderButton : Button) : void {
			if (_sliderButton != sliderButton) {
				_sliderButton = sliderButton;
				hasChanged();
			}
		}

		public function get value() : Number {
			return _value;
		}

		public function set value(value : Number) : void {
			if (_value != value) {
				_value = value;
				hasChanged();
			}
		}

		public function get maxValue() : Number {
			return _maxValue;
		}

		public function set maxValue(maxValue : Number) : void {
			if (_maxValue != maxValue) {
				_maxValue = maxValue;
				hasChanged();
			}
		}

		public function get minValue() : Number {
			return _minValue;
		}

		public function set minValue(minValue : Number) : void {
			if (_minValue != minValue) {
				_minValue = minValue;
				hasChanged();
			}
		}
	}
}
