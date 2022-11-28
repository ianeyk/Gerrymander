import geopandas as gpd
polygon = gpd.GeoDataFrame.from_file("polygons.shp")
geoms = polygon['geometry'].tolist()
dual = gpd.GeoDataFrame(gpd.GeoSeries([LineString([poly1.centroid, poly2.centroid]) for poly1,poly2 in  itertools.combinations(geoms, 2) if poly1.touches(poly2)]),columns=['geometry'])
dual.to_file("dual_graph2.shp")