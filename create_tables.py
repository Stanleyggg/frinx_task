import psycopg2

def create_table_query():
    query = """
                    CREATE TABLE interfaces (
                    id SERIAL PRIMARY KEY,
                    connection INTEGER,
                    name VARCHAR(255) NOT NULL,
                    description VARCHAR(255),
                    config json,
                    type VARCHAR(50),
                    infra_type VARCHAR(50),
                    port_channel_id INTEGER,
                    max_frame_size INTEGER
                )
            """

    return query

def connect():
    return psycopg2.connect(database = "postgres",
                            user = 'postgres',
                            password = 'oknats',
                            host = '127.0.0.1',
                            port = '5432')

def create_db(query):
    try:
        conn = connect()
        cur = conn.cursor()
        cur.execute(query)
        cur.close()
        conn.commit()
        conn.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


if __name__ == '__main__':
    query = create_table_query()
    create_db(query)
