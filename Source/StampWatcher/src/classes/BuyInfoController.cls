/*******************************************************************************
 * まいすたんぷ
 *
 * クラス名 : BuyInfoController
 * 概要 : 購入情報の管理
 * 作成者 : 盧　永軍
 * 作成日 : 2016/11/04
 * 変更履歴 :
 *
 ******************************************************************************/
public with sharing class BuyInfoController {

    /** ビュー */
    public BuyInfoView view {get; set;}
    /** Biz */
    public BuyInfoBiz biz {get; set;}

	public BuyInfoController() {
		System.assert(false, 'デフォルトコンストラクタは禁止です。');
	}

	/**
	 * コンストラクタ
	 * @param ApexPages.StandardController
	 * @return ORD_SalesOrderDetailCtrl
	 */
	public BuyInfoController(ApexPages.StandardController stdController) {

		view = new BuyInfoView();
		view.buyInfo = (BuyInfo__c)stdController.getRecord();

		biz = new BuyInfoBiz();

		biz.init(view);
	}

	public void sortByName() {
	    view.sortOrder = 'Name';
	    biz.convertSC(view);
	    biz.getDetail(view);
	}
	    
	public void sortByPrice(){
	    view.sortOrder = 'price__c';
	    biz.convertSC(view);
	    biz.getDetail(view);
	}

	public void sortByMaster(){
	    view.sortOrder = 'stampMasterRef__c';
	    biz.convertSC(view);
	    biz.getDetail(view);
	}

	public void sortByLevel(){
	    view.sortOrder = 'level__c';
	    biz.convertSC(view);
	    biz.getDetail(view);
	}

	 /**
     * 保存処理を実行します
     * @param Boolean isOrder true:承認申請を行う、false:承認申請を行わない
     * @param Boolean isNew true:新規画面に遷移する、false:詳細画面に遷移する
     * @return PageReference
     */
    public void doSave(){

    	try{
    		upsert view.buyInfo;
    		upsert view.buyInfoListForDb;
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '保存しました。'));
    	}
    	catch(Exception e){
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'エラーが発生しました。'));
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getStackTraceString()));
    	}

    }

     /**
     * 保存処理を実行します
     * @param Boolean isOrder true:承認申請を行う、false:承認申請を行わない
     * @param Boolean isNew true:新規画面に遷移する、false:詳細画面に遷移する
     * @return PageReference
     */
    public void doAdd(){
    	buyInfoDetail__c bid = new buyInfoDetail__c(buyInfoRef__c=view.buyInfo.id);

    	view.buyInfoList.add(new BuyInfoView.detailData(bid,view.buyInfoList.size()+1));
    }

    /**
     * 保存処理を実行します
     * @param Boolean isOrder true:承認申請を行う、false:承認申請を行わない
     * @param Boolean isNew true:新規画面に遷移する、false:詳細画面に遷移する
     * @return PageReference
     */
    public void doDelete(){

    	view.buyInfoListForDeleted = new List<BuyInfoDetail__c>(); 
    	List<BuyInfoView.detailData> notDelList = new List<BuyInfoView.detailData>();

	    for(BuyInfoView.detailData dd : view.buyInfoList){
	    	if(dd.isChecked){
	    		if(String.isNotBlank(dd.buyInfoDetail.Id)){
	    			view.buyInfoListForDeleted.add(dd.buyInfoDetail);
	    		}
	    	}else{
	    		notDelList.add(dd);
	    	}
	    }

	    view.buyInfoList = notDelList;
	    delete view.buyInfoListForDeleted;

    }

    /**
     * 保存処理を実行します
     * @param Boolean isOrder true:承認申請を行う、false:承認申請を行わない
     * @param Boolean isNew true:新規画面に遷移する、false:詳細画面に遷移する
     * @return PageReference
     */
    public void doCheckAll(){

	    for(BuyInfoView.detailData dd : view.buyInfoList){
	    	dd.isChecked = view.isCheckedAll;	
	    }
    }

    public void doFirst(){
    	view.pageNumber = 1;
    	biz.getDetail(view);
    }

    public void doPrevious(){
    	if(view.pageNumber > 1){
    		view.pageNumber--;
    	}
    	biz.getDetail(view);
	 
    }

    public void doPageNumber(){
    	view.pageNumber = view.clickPageNumber;
    	biz.getDetail(view);
    }

    public void doNext(){

    	view.pageNumber++;
    	biz.getDetail(view);
	 
    }

    public void doLast(){
    	
    	view.pageNumber = view.pageNumberLinks.size();
    	biz.getDetail(view);
    }


}