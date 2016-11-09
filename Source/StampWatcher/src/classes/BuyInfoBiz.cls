/*******************************************************************************
 * まいすたんぷ
 *
 * クラス名 : BuyInfoBiz
 * 概要 : 購入情報の管理Bizクラス
 * 作成者 : 盧　永軍
 * 作成日 : 2016/11/04
 * 変更履歴 :
 *
 ******************************************************************************/
public with sharing class BuyInfoBiz {
	
	public static final Integer RECORDER_NUMBER = 2;

	/**
	 * 画面初期化
	 * @param BuyInfoView
	 * @return 
	 */
	public void init(BuyInfoView view) {

		view.sortOrder = 'Name';
		view.orderSC = 'ASC';
		view.buyInfoList = new List<BuyInfoView.detailData>();
		view.isCheckedAll = false;
		view.pageNumber = 1;
		getDetail(view);

	}

	/**
	 * 画面初期化
	 * @param BuyInfoView
	 * @return 
	 */
	public Integer calcOffset(Integer recorderNumbers,Integer currentPage) {
		if(currentPage==null){
			currentPage = 1;
		}
		return (currentPage-1)*recorderNumbers;

	}

	/**
	 * 画面初期化
	 * @param BuyInfoView
	 * @return 
	 */
	public void getDetail(BuyInfoView view) {

		getPagingInfo(view);

		view.buyInfoList.clear();

		view.offset = calcOffset(RECORDER_NUMBER, view.pageNumber);

		String sqlwhere = 
				  '	select '
				+ '		id'
				+ '		,Name'
				+ '		,stampMasterRef__c'
				+ '		,price__c'
				+ '		,isReturned__c'
				+ '		,level__c'
				+ '	from buyInfoDetail__c'
				+ ' where buyInfoRef__c = \'' + view.buyInfo.Id + '\''
				+ ' order by ' + view.sortOrder + ' ' + view.orderSC
				+ ' limit ' + RECORDER_NUMBER
				+ ' offset ' + view.offset;
	
		List<buyInfoDetail__c> bList =  DataBase.query(sqlwhere);

		Integer rowNumber = 1;
		for(buyInfoDetail__c bid : bList){
			BuyInfoView.detailData dd = new BuyInfoView.detailData(bid, rowNumber++);
			view.buyInfoList.add(dd);
		}
		
	}

	/**
	 * 画面初期化
	 * @param BuyInfoView
	 * @return 
	 */
	public void getPagingInfo(BuyInfoView view) {

		AggregateResult result = [select count(Id) cnt from buyInfoDetail__c where buyInfoRef__c = :view.buyInfo.Id];
        
        view.recCount = Integer.valueOf(result.get('cnt'));
        if(view.recCount == 0){
        	return;
        }

        Integer totalPages = view.recCount/BuyInfoBiz.RECORDER_NUMBER;

    	if(Math.mod(view.recCount, BuyInfoBiz.RECORDER_NUMBER)>0){
    		totalPages++;
    	}

    	view.pageNumberLinks = new List<Integer>();
    	for(Integer i=1;i<=totalPages;i++){
        	view.pageNumberLinks.add(i);
        }
        
	}


	/**
	 * 画面初期化
	 * @param BuyInfoView
	 * @return 
	 */
	public void convertSC(BuyInfoView view) {

		if(view.orderSC == 'ASC'){
			view.orderSC = 'DESC';
		}else if(view.orderSC == 'DESC'){
			view.orderSC = 'ASC';
		}
	}
}