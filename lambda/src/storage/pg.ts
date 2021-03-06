import {Client} from 'pg'
import {UmzugStorage, MigrationParams} from 'umzug'
import {StorageContext} from './index'

export class PostgreSQLStorage implements UmzugStorage<StorageContext<Client>> {
    async logMigration ({ name, context}: MigrationParams<StorageContext<Client>>) {
        const {client, table} = context
        await client.query(`insert into ${table}(name) values(?)`, [name])
    }

    async unlogMigration ({ name, context}: MigrationParams<StorageContext<Client>>) {
        const {client, table} = context
        await client.query(`delete from ${table} where name = ?`, [name])
    }

    async executed ({context}: Pick<MigrationParams<StorageContext<Client>>, 'context'>) {
        const {client, table} = context
        await client.query(`create table if not exists ${table}(name text)`)
        const {rows} = await client.query(`select name from ${table}`)
        return rows.map(({name}: {name: string}) => name)
    }
}
