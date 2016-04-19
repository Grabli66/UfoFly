import kha.graphics2.Graphics;
import kha.Color;

class LoaderScreen {		
	public function new() {}
	
	/*
	* Возвращает набор ресурсов для загрузки. Переопределяется
	*/
	public function getAssetInfo() {}
	
	/*
	* Вызывается при загрузке ресурса. Переопределяется
	*/
	public function onProgress(index, total: Int){}
	
	/*
	* Рисует окно загрузки
	*/
	public function render(g: Graphics) {}
}