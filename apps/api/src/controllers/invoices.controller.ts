import { Body, Controller, HttpCode, HttpStatus, Post } from "@nestjs/common";
import { InvoicesService } from "../services/invoices.service";
import { SaveInvoiceDTO } from "../dto/invoices/save_invoice.dto";

@Controller('invoices')
export class InvoicesController {

    constructor(
        private readonly invoicesService: InvoicesService
    ) {}

    @Post()
    @HttpCode(HttpStatus.ACCEPTED)
    async saveInvoice(
        @Body() body: SaveInvoiceDTO
    )
    {
        this.invoicesService.saveInvoice(body);
        return
    }
}