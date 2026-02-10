#!/bin/bash

# 🚀 Damo AI Features - Test Runner
# 이 스크립트는 프로젝트의 모든 테스트를 실행하거나 특정 계층의 테스트를 선택해서 실행합니다.

# 현재 디렉토리를 PYTHONPATH에 추가 (shared 모듈 임포트 방지)
export PYTHONPATH=$PYTHONPATH:$(pwd)

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

show_header() {
    clear
    echo "================================================"
    echo -e "${YELLOW}🧪 Damo AI Test Runner${NC}"
    echo "================================================"
}

show_header
echo "테스트 범위를 선택하세요:"
echo "1) 📦 전체 테스트 실행 (All Tests)"
echo "2) 🧱 Shared 모듈 테스트 (Unit Tests)"
echo "3) ⚙️  Services 통합 테스트 (Integration Tests)"
echo "q) ❌ 종료"
echo "------------------------------------------------"

read -p "선택 (1-3/q): " choice

case $choice in
    1)
        echo -e "\n${BLUE}전체 테스트를 실행합니다...${NC}"
        pytest -v test/
        ;;
    2)
        echo -e "\n${BLUE}Shared 모듈 테스트를 실행합니다...${NC}"
        pytest -v test/shared/
        ;;
    3)
        echo -e "\n${BLUE}Services 통합 테스트를 실행합니다...${NC}"
        pytest -v test/services/
        ;;
    q)
        echo "종료합니다."
        exit 0
        ;;
    *)
        echo -e "${RED}❌ 잘못된 선택입니다.${NC}"
        exit 1
        ;;
esac
