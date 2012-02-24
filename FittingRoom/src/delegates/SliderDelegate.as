package delegates
{
	import controls.Slider;

	public interface SliderDelegate
	{
		function valueChanged(view : Slider, value : Number):void;
	}
}