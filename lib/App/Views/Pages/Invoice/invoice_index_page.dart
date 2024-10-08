import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_index_controller.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_analytics_section.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_body.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_body_header.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_filter_section.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_status_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/invoice_create_or_edit_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceIndexPage extends GetView<InvoiceIndexController> {
  const InvoiceIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceIndexController>(
      init: InvoiceIndexController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                BuildInvoiceAnalyticsSection(
                  clients: controller.clients.length,
                  invoices: controller.invoices.length,
                  outstanding: controller.outstanding,
                  overdue: controller.overdue,
                ),
                BuildInvoiceFilterSection(
                  filter: controller.filter,
                  length: controller.length,
                  onCreate: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => BuildDefultDialog(
                        width: context.width * 0.9,
                        height: context.height * 0.9,
                        padding: EdgeInsets.zero,
                        child: InvoiceCreateOrEditPage(
                          clients: controller.clients,
                          onInvoiceCreate: () async =>
                              await controller.fetchApi(),
                        ),
                      ),
                    );
                  },
                  onLengthChanged: controller.onLengthChange,
                  onFilterChanged: controller.onFilterChange,
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 10.0.spa,
                    left: 10.0.spa,
                    top: 20.spa,
                  ),
                  padding: EdgeInsets.only(
                    left: 5.0.spa,
                    right: 5.spa,
                    top: 5.spa,
                    bottom: 5.spa,
                  ),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const BuildInvoiceBodyHeader(),
                ),
                Expanded(
                  child: BuildLoadingOrEmptyLayout(
                    isLoading: controller.isLoading,
                    isEmpty: controller.filteredInvoices.isEmpty,
                    title: 'No Invoices Found',
                    child: ListView.separated(
                      padding: EdgeInsets.all(10.spa),
                      itemCount: controller.filteredInvoices.length,
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 5.spa);
                      },
                      itemBuilder: (_, int index) {
                        InvoiceModel invoice =
                            controller.filteredInvoices[index];

                        return Container(
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(5.spa),
                          child: BuildInvoiceBody(
                            onView: controller.viewInvoice,
                            onDelete: controller.deleteInvoice,
                            onDuplicate: controller.duplicateInvoice,
                            onExportAsPdf: controller.exportAsPdf,
                            printInvoice: controller.printInvoice,
                            invoice: invoice,
                            onEdit: (item) async {
                              await showDialog(
                                context: context,
                                builder: (_) => BuildDefultDialog(
                                  width: context.width * 0.9,
                                  height: context.height * 0.9,
                                  padding: EdgeInsets.zero,
                                  child: InvoiceCreateOrEditPage(
                                    invoice: item,
                                    clients: controller.clients,
                                    onInvoiceCreate: () async =>
                                        await controller.fetchApi(),
                                  ),
                                ),
                              );
                            },
                            onStatusPressed: (item) async {
                              await showDialog(
                                context: context,
                                builder: (_) {
                                  return BuildInvoiceStatusDialog(
                                    onStatusChanged: (status) =>
                                        controller.onStatusChanged(
                                      item: item,
                                      status: status,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
