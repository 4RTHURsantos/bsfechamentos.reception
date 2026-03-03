import { Controller, Get } from "@nestjs/common";
import "dotenv/config";

@Controller()
export class ApiController {

    constructor() { }

    @Get()
    helloWorld()
    {
        return {
            success: true,
            message: "✅ API está funcionando!",
            rootFolder: process.env.ROOT_FOLDER,
            timestamp: new Date().toISOString()
        }
    }

}