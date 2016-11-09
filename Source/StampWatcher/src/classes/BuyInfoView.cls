/*******************************************************************************
 * まいすたんぷ
 *
 * クラス名 : BuyInfoView
 * 概要 : 購入情報のView
 * 作成者 : 盧　永軍
 * 作成日 : 2016/11/04
 * 変更履歴 :
 *
 ******************************************************************************/
public with sharing class BuyInfoView {


	public BuyInfo__c buyInfo {get;set;} 

	public List<detailData> buyInfoList {get;set;} 

	public List<BuyInfoDetail__c> buyInfoListForDeleted {get;set;} 
	
	public List<BuyInfoDetail__c> buyInfoListForDb {
		get{
			List<BuyInfoDetail__c> bList = new List<BuyInfoDetail__c>();
			for(detailData dd : buyInfoList){
				bList.add(dd.buyInfoDetail);
			}
			return bList;
		}
	} 

	public String sortOrder {get;set;}

	public String orderSC {get;set;}

	public Boolean isCheckedAll {get;set;}

	/*ページング*/
	public Integer recCount{get;set;}

	public Boolean isFirst {
		get{
			return (pageNumber == 1);
		}
		set;}
	public Boolean hasPrevious {
			get{
				return (pageNumber > 1);
			}
			set;
		}
	public Boolean hasNext {
			get{
					return pageNumber*BuyInfoBiz.RECORDER_NUMBER < recCount;
				}
				set;
			}
	public Boolean isLast {
				get{
					return (pageNumber == recCount);
				}
				set;
			}

	public Integer pageNumber {
				get{
					if(pageNumber==null){
						pageNumber = 1;
					}
					return pageNumber;
				}

				set;
			}
	
	public Integer clickPageNumber {get;set;}

	public Integer offset {
			get{
				if(offset == null){
					offset = 0;
				}
				return offset;
			}

			set;
		}

	public List<Integer> pageNumberLinks{
				get;
				set;
			}

	public class detailData {

		public BuyInfoDetail__c buyInfoDetail {get;set;}
		public Boolean isChecked {get;set;}
		public Integer rowNumber {get;set;}
		public detailData(BuyInfoDetail__c buyInfoDetail, Integer rowNumber){
			this.buyInfoDetail = buyInfoDetail;
			this.rowNumber = rowNumber;
			this.isChecked = false;
		}
	}
}