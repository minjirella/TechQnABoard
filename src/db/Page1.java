package db;

public class Page1 {

	public static void main(String[] args) {
		int page = 2;
		int total = 32; //전체 게시물의 수
		int totalPage = 0; //전체 페이지수는 4가 되어야한다.
		if(total % 10 == 0) {
			totalPage = total / 10;
		}else {
			totalPage = total / 10 + 1;
		}
		System.out.println(totalPage);
		
		int startRow = 0;
		int endRow = 0;
		endRow = page*10;
		startRow = endRow-9;
		
		System.out.println(startRow);
		System.out.println(endRow);
		
		int startPage = 0;
		int endPage = 0;
		
		startPage = (page-1) / 10 * 10 +1;
		endPage = startPage + 9;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		System.out.println(startPage);
		System.out.println(endPage);
	}

}
