package jp.matsu4512
{
	import flash.display.Bitmap;

	public class ImageSlider extends Slider
	{
		private var imgButton:ImageButton;
		
		public function ImageSlider(type:String, bar_img:Bitmap, button_img_normal:Bitmap, button_img_over:Bitmap, button_img_down:Bitmap)
		{
			super(type, 0, 0, bar_img.width, bar_img.height);
			imgButton = new ImageButton(button_img_normal, button_img_over, button_img_down);
			button.graphics.clear();
			bar.graphics.clear();
			image_draw(bar_img, imgButton);
		}
		
		public function image_draw(bar_img:Bitmap, button_img:ImageButton):void{
			bar.addChild(bar_img);
			bar_img.x = -bar_img.width/2;
			bar_img.y = -bar_img.height/2;
			button.addChild(button_img);
			button_img.x = -button_img.width/2;
			button_img.y = -button_img.height/2;
		}
	}
}