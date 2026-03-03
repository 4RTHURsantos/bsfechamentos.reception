import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { mkdir, writeFile } from 'fs/promises'; // Importe a versão de promessas
import { join } from 'path';
import { SaveInvoiceDTO } from '../dto/invoices/save_invoice.dto';

@Injectable()
export class InvoicesService {
    async saveInvoice(dto: SaveInvoiceDTO) {
        const rootFolder = process.env.ROOT_FOLDER || join(__dirname, '..', '..');
        
        // Organização das pastas: documento/modelo/ano/mes/dia
        const saveFolder = join(
            rootFolder, 
            dto.document, 
            dto.nfe_mod, 
            dto.issue_date.getFullYear().toString(), 
            (dto.issue_date.getMonth() + 1).toString().padStart(2, '0'), 
            dto.issue_date.getDate().toString().padStart(2, '0')
        );

        const filePath = join(saveFolder, `${dto.nfe_key}.xml`);

        try {
            // mkdir com recursive: true não dá erro se a pasta já existir
            await mkdir(saveFolder, { recursive: true });

            // Agora que garantimos que a pasta existe (await), gravamos o arquivo
            await writeFile(filePath, dto.xml);
            
            return { success: true, path: filePath };
        } catch (err) {
            console.error('Erro ao salvar XML:', err);
            throw new InternalServerErrorException('Não foi possível salvar o arquivo XML.');
        }
    }
}