```````````````````java
public static Stack<MaxMinRawTile> getTiles(MapView mOsmv, int downloadlevel) {
		Stack<MaxMinRawTile> maxmintiles = new Stack<MaxMinRawTile>();
		// getTilesCount(mOsmv, maxmintiles, false, downloadlevel);

		int zoomLevel = mOsmv.getZoomLevel();
		String mapName = mOsmv.getTileSource().CacheDatabaseName();

		GeoPoint gp_topleft = mOsmv.getLeftTopPoint(0, 0);
		final int[] topLeftMapTileCoords = Util.getMapTileFromCoordinates(gp_topleft.getLatitudeE6(),
                                           gp_topleft.getLongitudeE6(), zoomLevel, null, 1);

		GeoPoint gp_rightbottom = mOsmv.getLeftTopPoint(mOsmv.getWidth(), mOsmv.getHeight());
		final int[] rightBottomMapTileCoords = Util.getMapTileFromCoordinates(gp_rightbottom.getLatitudeE6(),
                                               gp_rightbottom.getLongitudeE6(), zoomLevel, null, 1);

		int minTileX = topLeftMapTileCoords[1];
		int maxTileX = rightBottomMapTileCoords[1];
		int minTileY = topLeftMapTileCoords[0];
		int maxTileY = rightBottomMapTileCoords[0];

		minTileX = minTileX < 0 ? 0 : minTileX;
		minTileY = minTileY < 0 ? 0 : minTileY;
		/**
		 * 添加不同级别，最大、最小的瓦片
		 */
		int x = 1;// 倍数
		switch (downloadlevel) {
		case R.id.radio_cursory:
            //cursory_zooms  --  8, 9, 10, 11, 12
			for (int z = cursory_zooms[0]; z <= cursory_zooms[cursory_zooms.length - 1]; z++) {
				x = 0;
				if (zoomLevel > z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					MaxMinRawTile tile = new MaxMinRawTile((int) (maxTileX / x),
                                                          (int) (minTileX / x),
                                                          (int) (maxTileY / x),
                                                          (int) (minTileY / x), z, mapName);
					maxmintiles.add(tile);
				} else if (zoomLevel == z) {
					MaxMinRawTile tile = new MaxMinRawTile((int) (maxTileX), (int) (minTileX), (int) (maxTileY), (int) (minTileY), z, mapName);
					maxmintiles.add(tile);
				} else if (zoomLevel < z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					MaxMinRawTile tile = new MaxMinRawTile(maxTileX * x, minTileX * x, maxTileY * x, minTileY * x, z, mapName);
					maxmintiles.add(tile);
				}
			}
			// maxmintiles.add(object)
			break;
		case R.id.radio_normal:
			for (int z = normal_zooms[0]; z <= normal_zooms[normal_zooms.length - 1]; z++) {
				x = 0;
				if (zoomLevel > z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					MaxMinRawTile tile = new MaxMinRawTile((int) (maxTileX / x), (int) (minTileX / x), (int) (maxTileY / x), (int) (minTileY / x), z, mapName);
					maxmintiles.add(tile);
				} else if (zoomLevel == z) {
					MaxMinRawTile tile = new MaxMinRawTile((int) (maxTileX), (int) (minTileX), (int) (maxTileY), (int) (minTileY), z, mapName);
					maxmintiles.add(tile);
				} else if (zoomLevel < z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					MaxMinRawTile tile = new MaxMinRawTile(maxTileX * x, minTileX * x, maxTileY * x, minTileY * x, z, mapName);
					maxmintiles.add(tile);
				}
			}
			break;
		case R.id.radio_subtly:
			for (int z = subtly_zooms[0]; z <= subtly_zooms[subtly_zooms.length - 1]; z++) {
				x = 0;
				if (zoomLevel > z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					MaxMinRawTile tile = new MaxMinRawTile((int) (maxTileX / x), (int) (minTileX / x), (int) (maxTileY / x), (int) (minTileY / x), z, mapName);
					maxmintiles.add(tile);
				} else if (zoomLevel == z) {
					MaxMinRawTile tile = new MaxMinRawTile((int) (maxTileX), (int) (minTileX), (int) (maxTileY), (int) (minTileY), z, mapName);
					maxmintiles.add(tile);
				} else if (zoomLevel < z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					MaxMinRawTile tile = new MaxMinRawTile(maxTileX * x, minTileX * x, maxTileY * x, minTileY * x, z, mapName);
					maxmintiles.add(tile);
				}
			}
			break;
		default:
			break;
		}
		return maxmintiles;
	}

    /**
     *
     * @param mOsmv
     * @param downloadlevel  三个取值
     *          <ol>
     *              <li>R.id.radio_cursory</li>
     *              <li>R.id.radio_normal </li>
     *              <li>R.id.radio_subtly</li>
     *          </ol>
     * @return
     */

public static int getTilesCount(MapView mOsmv, int downloadlevel) {
		// GeoPoint gp_mapCenter = mOsmv.getMapCenter();
		int zoomLevel = mOsmv.getZoomLevel();
		
        //左上角
		GeoPoint gp_topleft = mOsmv.getLeftTopPoint(0, 0);
		final int[] topLeftMapTileCoords = Util.getMapTileFromCoordinates(gp_topleft.getLatitudeE6(),
                                            gp_topleft.getLongitudeE6(), zoomLevel, null, 1);

		// Ut.dd("MapTileCoordsX_topleft = " + topLeftMapTileCoords[1]);
		// Ut.dd("MapTileCoordsY_topleft = " + topLeftMapTileCoords[0]);

        //右下角
		GeoPoint gp_rightbottom = mOsmv.getLeftTopPoint(mOsmv.getWidth(), mOsmv.getHeight());
		final int[] rightBottomMapTileCoords = Util.getMapTileFromCoordinates(gp_rightbottom.getLatitudeE6(),
                                                gp_rightbottom.getLongitudeE6(), zoomLevel, null, 1);

		int minTileX = topLeftMapTileCoords[1];
		int maxTileX = rightBottomMapTileCoords[1];
		int minTileY = topLeftMapTileCoords[0];
		int maxTileY = rightBottomMapTileCoords[0];

		int count = 0;
		minTileX = minTileX < 0 ? 0 : minTileX;
		minTileY = minTileY < 0 ? 0 : minTileY;
		/**
		 * 添加不同级别，最大、最小的瓦片
		 */

		int x = 1;// 倍数
		switch (downloadlevel) {
		case R.id.radio_cursory:
            //粗略
			for (int z = cursory_zooms[0]; z <= cursory_zooms[cursory_zooms.length - 1]; z++) {
				x = 0;
				if (zoomLevel > z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					for (int i = minTileX / x; i <= maxTileX / x; i++) {
						for (int j = minTileY / x; j <= maxTileY / x; j++) {
							count++;
						}
					}
				} else if (zoomLevel == z) {
					for (int i = minTileX; i <= maxTileX; i++) {
						for (int j = minTileY; j <= maxTileY; j++) {
							count++;
						}
					}
				} else if (zoomLevel < z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					for (int i = minTileX * x; i <= maxTileX * x; i++) {
						for (int j = minTileY * x; j <= maxTileY * x; j++) {
							count++;
						}
					}
				}
			}
			break;
		case R.id.radio_normal:
            //普通
			for (int z = normal_zooms[0]; z <= normal_zooms[normal_zooms.length - 1]; z++) {
				x = 0;
				if (zoomLevel > z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					for (int i = minTileX / x; i <= maxTileX / x; i++) {
						for (int j = minTileY / x; j <= maxTileY / x; j++) {
							count++;
						}
					}
				} else if (zoomLevel == z) {
					for (int i = minTileX; i <= maxTileX; i++) {
						for (int j = minTileY; j <= maxTileY; j++) {
							count++;
						}
					}
				} else if (zoomLevel < z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					for (int i = minTileX * x; i <= maxTileX * x; i++) {
						for (int j = minTileY * x; j <= maxTileY * x; j++) {
							count++;
						}
					}
				}
			}
			break;
		case R.id.radio_subtly:
            //精细
			for (int z = subtly_zooms[0]; z <= subtly_zooms[subtly_zooms.length - 1]; z++) {
				// Ut.dd("Start end Distance="+distance+unit);
				x = 0;
				if (zoomLevel > z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					for (int i = minTileX / x; i <= maxTileX / x; i++) {
						for (int j = minTileY / x; j <= maxTileY / x; j++) {
							count++;
						}
					}
				} else if (zoomLevel == z) {
					for (int i = minTileX; i <= maxTileX; i++) {
						for (int j = minTileY; j <= maxTileY; j++) {
							count++;
						}
					}
				} else if (zoomLevel < z) {
					x = (int) Math.pow(2, Math.abs(zoomLevel - z));
					for (int i = minTileX * x; i <= maxTileX * x; i++) {
						for (int j = minTileY * x; j <= maxTileY * x; j++) {
							count++;
						}
					}
				}

			}
			break;
		default:
			break;
		}

		return count;
	}
	
	
````````````````````
