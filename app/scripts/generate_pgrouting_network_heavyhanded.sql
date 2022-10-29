create table lts_ways_heavyhanded as (
    select gid as id,
           fromnodeno::int as source,
           tonodeno::int as target,
           linklts,
           st_length(geom) * 3.28084 as len_feet,
           case
                when linklts in ('LTS 1', 'Off-road trail/path') then st_length(geom)
                when linklts = 'LTS 2' then st_length(geom) * 10
                when linklts = 'LTS 3' then st_length(geom) * 100
                when linklts = 'LTS 4' then st_length(geom) * 1000
            end as cost,
           10000000000000000000 as reverse_cost,
           st_transform(geom, 4326) as geom
     from
        existing_lts
     where
        geom is not null 
)