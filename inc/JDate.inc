ROUTINE JDate [Type=INC]
#define MeijiStart  9862
#define TaisyouStart  26143
#define SyouwaStart  31404
#define HeiseiStart  54064
#define ReiwaStart  65134

#define MeijiYear  1868
#define TaisyoYear  1912
#define SyouwaYear  1926
#define HeiseiYear  1989
#define ReiwaYear    2019
#define StartYear   1
#define MeijiStartMonthDate 0101
#define MeijiEndYear 45
#define MeijiEndMonthDate 729
#define TaisyoStartMonthDate 730
#define TaisyoEndYear 15
#define TaisyoEndMonthDate 1224
#define SyouwaStartMonthDate 1225
#define SyouwaEndYear 64
#define SyouwaEndMonthDate 107
#define HeiseiStartMonthDate 108
#define HeiseiEndYear 31
#define HeiseiEndMonthDate 430
#define ReiwaStartMonthDate 501
#define MaxReiwaYear 99

#define ShortExpression 1
#define LongExpression  2

#define ShortExpressionLength  7
#define LongExpressionLength  11

#define FormatError $System.Status.Error(4001,"Date Format Error")
#define RangeError $System.Status.Error(4002,"Date Range Error")
