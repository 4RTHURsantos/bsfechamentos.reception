import { Module } from '@nestjs/common';
import { InvoicesModule } from './modules/invoices.module';
import { ApiController } from './api.controller';

@Module({
  imports: [
    InvoicesModule
  ],
  controllers: [
    ApiController
  ],
  providers: [],
})
export class ApiModule {}
