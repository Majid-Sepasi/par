import Felgo 4.0
import QtQuick.Controls 2.15 as QC2
import QtQuick 2.15
App {

    ListModel{
        id:listmodelId
    }
    ListModel{
        id:services
        ListElement{type:"One-month Services"; trafic:"20 GB"; userNo:"Two-user"; price :"40,000 IRT"}
        ListElement{type:"One-month Services"; trafic:"30 GB"; userNo:"Two-user"; price :"55,000 IRT"}
        ListElement{type:"One-month Services"; trafic:"40 GB"; userNo:"Two-user"; price :"70,000 IRT"}
        ListElement{type:"Three-month Services"; trafic:"100 GB"; userNo:"Two-user"; price :"160,000 IRT"}
        ListElement{type:"Three-month Services"; trafic:"150 GB"; userNo:"Two-user"; price :"230,000 IRT"}
        ListElement{type:"Three-month Services"; trafic:"200 GB"; userNo:"Two-user"; price :"290,000 IRT"}
    }

    Navigation {
        navigationMode: navigationModeTabs

        NavigationItem {
            title: "Services"
            iconType: IconType.listul

            NavigationStack {
                AppPage {
                    id:page
                    title: "List of Services"
                    AppListView{
                        delegate:services_delegate
                        model:services
                        section.property: "type"
                        section.delegate: SimpleSection{
                        }
                    }
                }
            }
        }

        NavigationItem {
            title: "Shopping Cart"
            iconType: IconType.shoppingcart
            NavigationStack {
                AppPage {
                    title: "Your Shopping Cart"

                    AppListView{
                        id:listviewId
                        delegate:shop_delegate
                        model:listmodelId
                        scrollsToTop: false
                        footer:AppButton{
                            width:parent.width
                            visible: (listmodelId.count !== 0)
                            text: "Share Factor"
                            onClicked: {
                                var totalCost = 0
                                var factor = "🕊 parvpn factor 🕊\n================\n\n";
                                for(var i = 0; i < listmodelId.count; i++){
                                    var serviceType = listmodelId.get(i).type[0] === 'O'? "1" : "3"
                                    serviceType += "-Month"
                                    factor += serviceType + ", ";
                                    factor += listmodelId.get(i).userNo + ", ";
                                    factor += listmodelId.get(i).trafic + ", ";
                                    factor += listmodelId.get(i).price + "\n";
                                    factor += "================================\n";
                                    var cost = listmodelId.get(i).price
                                    cost =  cost.replace(/\D/g, "");
                                    totalCost += parseInt(cost)
                                }
                                totalCost = totalCost.toString()
                                totalCost = totalCost.replace(/\d(?=(\d{3})+$)/g, '$&,')
                                factor += "\nTotal Cost: " + totalCost + " IRT\n"
                                console.log(factor)
                                nativeUtils.share(factor,"")
                            }
                        }
                    }

                    AppText {
                        anchors.centerIn: parent
                        text: "Your shopping cart is empty"
                        visible: (listmodelId.count === 0)
                    }
                }
            }
        }

        NavigationItem{
            iconType: IconType.calculator
            title: "Calculator"
            NavigationStack {
                AppPage {
                    title: "Custom Service Price Calculator"
                }
            }
        }
    }


    Component{
        id:services_delegate
        AppListItem{
            leftItem: AppIcon {
                iconType: IconType.twitter
                anchors.verticalCenter: parent.verticalCenter
                width: dp(26)
            }
            textItem: Row{
                spacing: dp(15)
                AppText{
                    text:trafic
                }
                AppText{
                    text:userNo
                }
                AppText{
                    text:price
                }
            }

            rightItem: IconButton{
                iconType: IconType.plus
                onClicked:{
                    listmodelId.append(services.get(index))
                }
            }
        }

    }


    Component{
        id:shop_delegate
        AppListItem{
            leftItem: AppIcon {
                iconType: IconType.check
                anchors.verticalCenter: parent.verticalCenter
                width: dp(26)
            }
            textItem: Row{
                spacing: dp(15)
                AppText{
                    text:trafic
                }
                AppText{
                    text:userNo
                }
                AppText{
                    text:price
                }
            }

            rightItem: IconButton{
                iconType: IconType.remove
                color:"red"
                onClicked:{
                    listmodelId.remove(index)
                }
            }
        }

    }
}
