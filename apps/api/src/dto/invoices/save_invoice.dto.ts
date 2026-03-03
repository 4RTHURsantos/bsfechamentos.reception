import { Type } from 'class-transformer';
import { IsDate, IsString } from 'class-validator';

export class SaveInvoiceDTO {
    @IsString()
    event: string;

    @IsString()
    nfe_mod: string;

    @IsString()
    nfe_key: string;

    @IsString()
    nfe_number: string;

    @IsString()
    nfe_series: string;

    @IsString()
    document: string;

    @IsString()
    xml: string;

    @IsDate()
    @Type(() => Date)
    issue_date: Date;
}