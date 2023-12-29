package chap06.model;

// 데이터 클래스, 모델, dto, vo, ...
// 컬렉션과 함께 사용하면서 데이터를 담아놓기 위한 용도의 클래스
public class PizzaOrder {
	
	String size;
	int qty;
	
	public PizzaOrder(String size, int qty) {
		this.size = size;
		this.qty = qty;
	}
	
	public String getSize() {
		return size;
	}
	
	public int getQty() {
		return qty;
	}
	
	@Override
	public String toString() {
		return String.format("<li>%s, %d판</li>", size, qty);
	}
}
